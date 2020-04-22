[TOC]

# crowd-funding部分笔记

之前学习了尚硅谷的众筹项目，趁着这段空闲的时间再次复现一下，一来熟悉下SSM项目的基本实现，二来记录整理方便日后的复看。浏览该系列文章需要有一定基础，包括但不局限于MySQL、Mybatis、Spring、SpringMVC、SpringBoot、SpringCloud等，使用的IDE是**IntelliJ IDEA 2019.1 x64**。本文主要是搭建出**后台管理的SSM环境**，具体的业务实现会在后续更新

## 一、工程的基本搭建

### 工程的创建

首先需要创建出一个新项目，并在新项目中搭建所需要的Maven工程，主要包括五个：

* funding-common-util
* funding-admin-parent
* funding-admin-component
* funding-admin-entity
* funding-admin-web

其中，funding-common-util与funding-admin-parent是并列关系，且其余三个是funding-admin-parent的子Module，具体工程的创建如下流程：

1. File -> New -> Project -> 选择Maven -> 填写GroupId和ArtifactId，这里分别为com.muzimz.funding、funding-admin-parent -> Project Location中填入工作目录，这里填写的是Idea/my-funding/funding-admin-parent -> finish

2. 创建完成之后，New -> project from existing source -> 选择my-funding -> 打开侧边栏的maven —> 点击+号 -> 选择funding-admin-parent的pom.xml文件，将该文件识别为maven工程

3. 在my-funding工作空间中，创建funding-common-util工程，与funding-admin-parent同级

4. 在funding-admin-parent工程中分别创建funding-admin-entity、funding-admin-component、funding-admin-web三个子Maven Module

创建完成之后，工程之间的关系如下：


![https://wx2.sbimg.cn/2020/04/15/2.png](https://wx2.sbimg.cn/2020/04/15/2.png)

### 依赖的导入

```xml
<!-- funding-common-util -->
<artifactId>servlet-api</artifactId>
<artifactId>fastjson</artifactId>
<artifactId>httpclient</artifactId>
<artifactId>jetty-util</artifactId>
<artifactId>commons-lang</artifactId>
<artifactId>fastdfs-client-java</artifactId>
<artifactId>commons-fileupload</artifactId>
<artifactId>commons-io</artifactId>

<!-- funding-admin-entity -->
<artifactId>lombok</artifactId>

<!-- funding-admin-component -->
<artifactId>funding-admin-entity</artifactId>
<artifactId>funding-common-util</artifactId>
<artifactId>spring-orm</artifactId>
<artifactId>spring-webmvc</artifactId>
<artifactId>aspectjweaver</artifactId>
<artifactId>cglib</artifactId>
<artifactId>mysql-connector-java</artifactId>
<artifactId>druid</artifactId>
<artifactId>mybatis</artifactId>
<artifactId>mybatis-spring</artifactId>
<artifactId>pagehelper</artifactId>
<artifactId>slf4j-api</artifactId>
<artifactId>logback-classic</artifactId>
<artifactId>jcl-over-slf4j</artifactId>

<!-- funding-admin-web -->
<artifactId>funding-admin-component</artifactId>
<artifactId>spring-test</artifactId>
<artifactId>junit</artifactId>
<artifactId>servlet-api</artifactId>
<artifactId>jsp-api</artifactId>
<artifactId>jsqlparser</artifactId>
<artifactId>funding-admin-entity</artifactId>
```

另外，需要在每一个pom.xml文件中配置Java的编译版本，如下所示配置：
```
<properties>
    <maven.compiler.source>1.8</maven.compiler.source>
    <maven.compiler.target>1.8</maven.compiler.target>
</properties>
```

### SSM的整合

工程的相关说明：

* funding-common-util主要是放置一些公共处理类，例如，Controller层同一返回的Json Result、短信发送、FastDFS文件上传等
* funding-admin-entity主要是用来存放一些Java实体类，PO、VO、DTO等
* funding-admin-component主要是用来放置mapper、service、controller、aop、exception、interceptor等
* funding-admin-web主要是与web打交道，并且Mybatis、Spring、logback等配置文件都是放置于此，值得一说的是，还需要在resources下创建与funding-admin-component所对应的mapper映射文件。

具体之间的关系如下：

```
funding-admin-entity
    com.muzimz.funding.entity
        Admin.Java
funding-admin-component
    com.muzimz.funding.mapper
        AdminMapper.Java
    com.muzimz.funding.service
        impl
            AdminServiceImpl.java
        AdminService.java
    com.muzimz.funding.controller
        AdminController.java
    com.muzimz.funding.aop
        ServiceAop.java
funding-admin-web
    resources
        mapper.AdminMapper.xml
        myabtis.mybatis-config.xml
        spring
            applicationContext-dao.xml
            applicationContext-service.xml
            applicationContext-transaction.xml
            springmvc.xml
        properties.db.properties
        logback.xml
```

在SSM整合的过程中，我们不需要单独配置mybatis-config.xml，其中数据源的配置都交给applicationContext-dao.xml进行配置

mybatis-config.xml
```
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE configuration
        PUBLIC "-//mybatis.org//DTD Config 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-config.dtd">
<configuration></configuration>
```

db.properties主要是配置数据库的连接信息
```
jdbc.user=root
jdbc.password=root
jdbc.url=jdbc:mysql://localhost:3306/my-funding?serverTimezone=UTC&useUnicode=true&characterEncoding=UTF-8
jdbc.driver=com.mysql.jdbc.Driver
```

applicationContext-dao.xml的配置暂时主要有以下几个：

* 配置dataSource
* 配置SqlSessionFactoryBean
* 配置MapperScannerConfigurer来扫描mapper

```
<!--    配置properties文件，读取数据库的连接信息-->
<context:property-placeholder location="classpath:properties/db.properties"></context:property-placeholder>

<bean id="dataSource" class="com.alibaba.druid.pool.DruidDataSource">
    <property name="driverClassName" value="${jdbc.driver}"></property>
    <property name="url" value="${jdbc.url}"></property>
    <property name="username" value="${jdbc.user}"></property>
    <property name="password" value="${jdbc.password}"></property>
</bean>

<!--    配置SqlSessionFactory-->
<bean class="org.mybatis.spring.SqlSessionFactoryBean">
    <property name="configLocation" value="classpath:mybatis/mybatis-config.xml"></property>
    <property name="dataSource" ref="dataSource"></property>
<!--        特别注意：配置dao与mapper.xml的映射-->
    <property name="mapperLocations" value="classpath:mapper/*.xml"></property>
</bean>

<!--    配置mapper扫描包-->
<bean class="org.mybatis.spring.mapper.MapperScannerConfigurer">
    <property name="basePackage" value="com.muzimz.funding.mapper"></property>
</bean>
```

applicationContext-service.xml只需要配置service的包扫描
```
<!--    配置service扫描-->
<context:component-scan base-package="com.muzimz.funding.service"></context:component-scan>
```

applicationContext-transaction.xml配置事务相关
这里需要注意的是，因为我们的Spring配置是分模块配置，所以在配置transaction的时候又可以能扫描不到applicationContext-dao.xml中的dataSource，我们需要进行如下操作：

File--->Project Structure--> Modules --> 点击+，将所有的.xml配置文件添加进去即可解决

```
<!--    配置事务管理器-->
<bean id="transactionManager" class="org.springframework.jdbc.datasource.DataSourceTransactionManager">
    <property name="dataSource" ref="dataSource" />
</bean>

<!--    通知-->
<tx:advice id="txAdvice" transaction-manager="transactionManager">
    <tx:attributes>
        <!-- 传播行为 -->
        <tx:method name="save*" propagation="REQUIRED" />
        <tx:method name="insert*" propagation="REQUIRED" />
        <tx:method name="add*" propagation="REQUIRED" />
        <tx:method name="create*" propagation="REQUIRED" />
        <tx:method name="delete*" propagation="REQUIRED" />
        <tx:method name="update*" propagation="REQUIRED" />
        <tx:method name="find*" propagation="SUPPORTS" read-only="true" />
        <tx:method name="select*" propagation="SUPPORTS" read-only="true" />
        <tx:method name="get*" propagation="SUPPORTS" read-only="true" />
        <tx:method name="query*" propagation="SUPPORTS" read-only="true" />
    </tx:attributes>
</tx:advice>

<aop:config>
    <aop:advisor advice-ref="txAdvice" pointcut="execution(* com.muzimz.funding.service.*.*(..))" />
</aop:config>

<aop:aspectj-autoproxy></aop:aspectj-autoproxy>

<context:component-scan base-package="com.muzimz.funding.aop"></context:component-scan>
```

## 二、测试

logback.xml

注意，需要在logger标签中指定对应的mapper包，才能显示sql语句
```
<?xml version="1.0" encoding="UTF-8"?>
<configuration debug="true">
	<!-- 指定日志输出的位置 -->
	<appender name="STDOUT"
		class="ch.qos.logback.core.ConsoleAppender">
		<encoder>
			<!-- 日志输出的格式 -->
			<!-- 按照顺序分别是：时间、日志级别、线程名称、打印日志的类、日志主体内容、换行 -->
			<pattern>[%d{HH:mm:ss.SSS}] [%-5level] [%thread] [%logger] [%msg]%n</pattern>
		</encoder>
	</appender>
	
	<!-- 设置全局日志级别。日志级别按顺序分别是：DEBUG、INFO、WARN、ERROR -->
	<!-- 指定任何一个日志级别都只打印当前级别和后面级别的日志。 -->
	<root level="INFO">
		<!-- 指定打印日志的appender，这里通过“STDOUT”引用了前面配置的appender -->
		<appender-ref ref="STDOUT" />
	</root>

	<!-- 根据特殊需求指定局部日志级别 -->
	<logger name="com.muzimz.funding.mapper" level="DEBUG"/>
	
</configuration>
```

注意这里的ContextConfiguration中的locations不能通过*来进行配置，将所有需要扫描的配置文件都要添加

```
@ContextConfiguration(locations = {"classpath:spring/applicationContext-dao.xml", "classpath:spring/applicationContext-service.xml",
"classpath:spring/applicationContext-transaction.xml", "classpath:spring/springmvc.xml"})
@RunWith(SpringJUnit4ClassRunner.class)
public class LoggerTest {

    private Logger logger = LoggerFactory.getLogger(LoggerTest.class);

    @Autowired
    private AdminMapper adminMapper;

    @Autowired
    private AdminService adminService;

    @Test
    public void testLogger() {
        Admin admin = new Admin(1, "dsada", "sdasdsa", "dfdfa", "asfadf", "fgeger");
        logger.info(admin.toString());
    }

    @Test
    public void testMapper() {
        AdminExample adminExample = new AdminExample();
        List<Admin> admins = adminMapper.selectByExample(adminExample);
        for (Admin admin: admins) {
            logger.info(admin.toString());
        }
    }

    @Test
    public void testService() {
        List<Admin> admins = adminService.selectAll();
        for (Admin admin: admins) {
            System.out.println(admin);
        }
    }
}
```

## 三、Mybatis相关

### 最外层mapper标签说明
```
<!-- 用来指定与mapper.xml对应的mapper.java类 -->
<mapper namespace="com.muzimz.funding.mapper.AdminMapper" >

</mapper>
```

### resultMap说明
```
<!-- 
    resultMap主要用来去别名，将数据库表字段名与Java变量名对应
    id：用于指定resultMap的唯一id，方面后面写Sql语句时对应
    type：指定对应映射实体类的全限定类名
    column：指定表字段
    property：指定实体类的成员变量
    jdbcType：指定类型，了解即可，最好加上
-->
<resultMap id="BaseResultMap" type="com.muzimz.funding.entity.Admin" >
    <id column="id" property="id" jdbcType="INTEGER" />
    <result column="login_acct" property="loginAcct" jdbcType="VARCHAR" />
</resultMap>
```

### 数据插入之后获取主键值
```
<!-- 
    数据插入之后返回对应的主键Id值 
    设置三个属性：
        useGeneratedKeys="true" 开启返回Id
        keyProperty="id"        实体类中的属性
        keyColumn="id"          数据库表中的字段
-->
<insert id="insertSelective" parameterType="com.muzimz.funding.entity.Admin" useGeneratedKeys="true" keyProperty="id" keyColumn="id">
......
</insert>

Admin admin = new Admin();
admin.set().set()......
adminMapper.insertSelective(admin);
sout(admin.getId());        // 成功插入之后就可以获取插入数据的Id值
```

### 关联查询（collection一对多，association一对一和多对一）

* 一对多。使用collection

需求说明：在PortalTypeVO.java中含有四个属性：Integer id，String  name，String remark，List<PortalProjectVO> portalProjectVOList，关键是如何查询type（分类）中对应的所有项目（project）。就好比查询一个在查询班级信息的同时，根据班级id把班级中所有的学生查询出来。

select属性：具体的联合查询id，通过mapper.的形式设置，另外selectPortalProjectVOList不必要在mapper.java中定义，因为在mapper.xml中会自动定位到
```
<!-- collection中属性说明：
    property属性：对应PortalTypeVO中分类数据中的项目数据的List属性名
    column属性：接下来查询项目时需要用到分类id（班级id，将班级id传入到学生表中查询所有的学生），就是通过column属性把值传入
    ofType属性：项目数据的实体类型PortalProjectVO（学生） 
    select属性：具体的联合查询id，通过mapper.的形式设置，另外selectPortalProjectVOList不必要在mapper.java中定义，因为在mapper.xml中会自动定位到
-->
<resultMap type="com.muzimz.crowd.entity.vo.PortalTypeVO" id="loadPortalProjectListResultMap">
    <!-- 分类数据的常规属性 -->
    <id column="id" property="id"/>
    <result column="name" property="name"/>
    <result column="remark" property="remark"/>
    
    <collection
            property="portalProjectVOList"
            column="id"
            ofType="com.muzimz.crowd.entity.vo.PortalProjectVO"
            select="com.muzimz.crowd.mapper.ProjectPOMapper.selectPortalProjectVOList"/>
</resultMap>

<!-- 
    我们实际需要调用的mapper方法selectPortalTypeVOList，传入了我们定义的resultMap：loadPortalProjectListResultMap
-->
<select id="selectPortalTypeVOList" resultMap="loadPortalProjectListResultMap">
	select id,name,remark from t_type
</select>

<!-- 
    上面联合查询的sql语句，换句话讲，我们在调用selectPortalTypeVOList的时候，就会自动调用 selectPortalProjectVOList，并且封装成PortalTypeVO进行返回
-->
<select id="selectPortalProjectVOList" resultType="com.muzimz.crowd.entity.vo.PortalProjectVO">
	SELECT
		t_project.id projectId,
		project_name projectName,
		money,
		deploydate deployDate,
		supportmoney/money*100 percentage,
		supporter supporter,
		header_picture_path headerPicturePath
		FROM t_project LEFT JOIN t_project_type ON t_project.id=t_project_type.projectid
	WHERE t_project_type.typeid=#{id}
	ORDER BY t_project.id DESC
	LIMIT 0,4
</select>
```

* 一对一，使用association

查询学生的时候，自动将他的card查询出来，**注意association 使用的是javaType，而不再是offType**
```
public class Card implements Serializable {
	private Integer id;
	private String code;
	// 省略get、set方法
}

public class User implements Serializable {
	private Integer id;
	private String name;
	private Integer age;
	private Card card;
	//省略get、set方法
}

<select id="selectCardById" parameterType="int" resultType="com.yrk.pojo.Card">
	select * from tb_card where id = #{id} 
</select>

<resultMap type="com.yrk.pojo.Person" id="personMapper">
	<id property="id" column="id"/>
	<result property="name" column="name"/>
	<result property="age" column="age"/>
	<association property="card" column="card_id" 
		select="com.yrk.mapper.CardMapper.selectCardById"
		javaType="com.yrk.pojo.Card">
	</association>
</resultMap>

<select id="selectPersonById" parameterType="int" resultMap="personMapper">
	select * from tb_person where id = #{id}
</select>
```

### 延迟加载

在我们使用collection和association进行关联查询的时候，如果不加处理，他一般会直接执行完，假设我们不需要使用查询后的数据，那这样就会大大损耗性能。所以我们可以采用延迟加载来避免这个问题，**开启延迟加载之后，我们采用collection和association进行多表查询出结果之后，只有当我们使用到结果它才会查询数据库，不使用就不会查询数据库。**

在mybatis-config.xml中开启延迟加载(lazyLoadingEnabled)：
```
<settings>
    <setting name="lazyLoadingEnabled" value="true"/>
    <setting name="aggressiveLazyLoading" value="false"/>
</settings>
```

lazyLoadingEnabled：true表示开启延迟加载
aggressiveLazyLoading：true表示对象中的属性全部加载，false表示按需加载

开启之后，我们调用联合查询，即可在控制台看见具体的SQL，使用到目标对象的时候他才会打印SQL。

### 分页插件PageHelper

```
文档：https://pagehelper.github.io/docs/howtouse/

F:\CodeLearning\2019-12封捷尚筹网\开发文档\06-尚硅谷-尚筹网-后台-管理员信息维护.pdf
```

## 四、统一异常处理

以用户注册场景，存在已注册用户为例。

### 自己定义一个异常LoginAcctAlreadyInUseException

```
package com.muzimz.funding.exception;

public class LoginAcctAlreadyInUseException extends RuntimeException {

    private static final long serialVersionUID = 1L;

    public LoginAcctAlreadyInUseException() {
    }

    public LoginAcctAlreadyInUseException(String message) {
        super(message);
    }

    public LoginAcctAlreadyInUseException(String message, Throwable cause) {
        super(message, cause);
    }

    public LoginAcctAlreadyInUseException(Throwable cause) {
        super(cause);
    }

    public LoginAcctAlreadyInUseException(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {
        super(message, cause, enableSuppression, writableStackTrace);
    }
}
```

### 创建一个异常处理类FundingExceptionResolve.java

判断是否为Ajax请求（作为一个工具方法）
```
/**
 * 判断当前请求是否为Ajax请求
 * @param request 请求对象
 * @return
 * 		true：当前请求是Ajax请求
 * 		false：当前请求不是Ajax请求
 */
public static boolean judgeRequestType(HttpServletRequest request) {
	
	// 1.获取请求消息头
	String acceptHeader = request.getHeader("Accept");
	String xRequestHeader = request.getHeader("X-Requested-With");
	
	// 2.判断
	return (acceptHeader != null && acceptHeader.contains("application/json"))
			
			||
			
			(xRequestHeader != null && xRequestHeader.equals("XMLHttpRequest"));
}
```

编写异常处理类FundingExceptionResolve，加入用户注册已存在的用户，则跳转到注册页面admin-add.jsp

```
// @ControllerAdvice表示当前类是一个基于注解的异常处理器类
@ControllerAdvice
public class FundingExceptionResolve {

    @ExceptionHandler(value = LoginAcctAlreadyInUseException.class)
    public ModelAndView resolveLoginAcctAlreadyInUseException(
            LoginAcctAlreadyInUseException exception,
            HttpServletRequest request,
            HttpServletResponse response
    ) throws IOException {
        String viewName = "admin-add";
        return commonResolve(viewName, exception, request, response);
    }
    
    // @ExceptionHandler将一个具体的异常类型和一个方法关联起来
    private ModelAndView commonResolve(

            // 异常处理完成后要去的页面
            String viewName,

            // 实际捕获到的异常类型
            Exception exception,

            // 当前请求对象
            HttpServletRequest request,

            // 当前响应对象
            HttpServletResponse response) throws IOException {

        // 1.判断当前请求类型
        boolean judgeResult = CrowdUtil.judgeRequestType(request);

        // 2.如果是Ajax请求
        if(judgeResult) {

            // 3.创建ResultEntity对象
            ResultEntity<Object> resultEntity = ResultEntity.failed(exception.getMessage());

            // 4.创建Gson对象
            Gson gson = new Gson();

            // 5.将ResultEntity对象转换为JSON字符串
            String json = gson.toJson(resultEntity);

            // 6.将JSON字符串作为响应体返回给浏览器
            response.getWriter().write(json);

            // 7.由于上面已经通过原生的response对象返回了响应，所以不提供ModelAndView对象
            return null;
        }

        // 8.如果不是Ajax请求则创建ModelAndView对象
        ModelAndView modelAndView = new ModelAndView();

        // 9.将Exception对象存入模型
        modelAndView.addObject("exception", exception);

        // 10.设置对应的视图名称
        modelAndView.setViewName(viewName);

        // 11.返回modelAndView对象
        return modelAndView;
    }

}
```

### 具体的业务代码（用户添加）

加入在注册时，已经存在用户，则会抛出我们自定义的异常（LoginAcctAlreadyInUseException），异常抛出之后会被我们之前的FundingExceptionResolve 捕捉到，并返回注册页面admin-add.jsp

```
@Override
public void saveAdmin(Admin admin) {
	Date date = new Date();
	SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	String createTime = simpleDateFormat.format(date);

	admin.setCreateTime(createTime);
	admin.setUserPswd(passwordEncoder.encode(admin.getUserPswd()));

	try {
		adminMapper.insert(admin);
	}catch (DuplicateKeyException e) {
		e.printStackTrace();
		if (e instanceof DuplicateKeyException) {
			throw new LoginAcctAlreadyInUseException(CrowdConstant.MESSAGE_LOGIN_ACCT_ALREADY_IN_USE);
		}
		throw e;
	}
}
```

## 五、SpringMVC相关

在springmvc.xml中配置view-controller，访问对应路径可进行直接跳转
```
<!--	配置view-controller，直接把请求地址和视图名称关联起来，不必写handler方法了
@RequestMapping("/admin/to/login/page.html")
public String toLoginPage() {
	return "admin-login";
}

访问/admin/to/login/page.html跳转到admin-login.jsp页面中
-->
<mvc:view-controller path="/admin/to/login/page.html" view-name="admin-login"/>
<mvc:view-controller path="/admin/to/main/page.html" view-name="admin-main"/>
<mvc:view-controller path="/admin/to/add/page.html" view-name="admin-add"/>
<mvc:view-controller path="/role/to/page.html" view-name="role-page"/>
<mvc:view-controller path="/menu/to/page.html" view-name="menu-page"/>
```

### 系统推出（session销毁）

```
<li><a href="admin/do/logout.html"><i class="glyphicon glyphicon-off"></i> 退出系统</a></li>

@RequestMapping(value="/admin/do/logout.html")
public String doLogout(HttpSession session) {
    session.invalidate();
    return "redirect:/admin/to/login/page.html"
}

<mvc:view-controller path="/admin/to/login/page.html" view-name="admin-login"/>
```

### 登录状态的检查（自定义一个异常，并对其进行处理）

有些资源仅供登录后才能无需登录即可访问，主要是通过拦截器进行控制

* 自定义AccessForbiddenException.java继承RuntimeException 
* 在异常处理中，对自定义AccessForbiddenException进行处理，如果捕捉到就返回admin-login页面，同上
* 创建拦截器LoginInterceptor，继承HandlerInterceptorAdapter进行拦截

假如session域中没有用户信息，则抛出异常，异常会被异常处理器拦截到，并返回admin-login页面

```
public class LoginInterceptor extends HandlerInterceptorAdapter {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        // 1. 通过request对象获取session对象
        HttpSession session = request.getSession();
        // 2. 尝试从session域中获取admin对象
        Admin admin = (Admin)session.getAttribute(CrowdConstant.ATTR_NAME_LOGIN_ADMIN);
        if (admin == null) {
            // 4. 抛出异常
            throw new AccessForbiddenException(CrowdConstant.MESSAGE_ACCESS_FORBIDEN);
        }
        // 5. 如果ADmin对象不为null，则返回true放行
        return super.preHandle(request, response, handler);
    }
}
```
* 在springmvc.xml文件中配置需要进行拦截的资源

主要是配置需要拦截的资源和不需要拦截的资源，以及拦截处理的类
```
<mvc:interceptors>
	<mvc:interceptor>
<!-- &lt;!&ndash;			需要拦截的资源，对应的是多层路径&ndash;&gt; -->
		<mvc:mapping path="/**"/>
<!-- &lt;!&ndash;			不需要拦截的页面&ndash;&gt; -->
		<mvc:exclude-mapping path="/admin/do/login/page.html"/>
		<mvc:exclude-mapping path="/admin/do/login.html"/>
		<mvc:exclude-mapping path="/admin/do/logout.html"/>
		<bean class="com.muzimz.crowd.mvc.interceptor.LoginInterceptor"></bean>
	</mvc:interceptor>
</mvc:interceptors>
```

## 六、前端相关

### Z-tree

```
F:\CodeLearning\2019-12封捷尚筹网\开发文档\09-尚硅谷-尚筹网-后台-菜单维护.pdf
```

## 七、Spring Security相关

* 导入依赖

```
<!-- SpringSecurity对Web应用进行权限管理 -->
<dependency>
    <groupId>org.springframework.security</groupId>
    <artifactId>spring-security-web</artifactId>
    <version>4.2.10.RELEASE</version>
</dependency>

<!-- SpringSecurity配置 -->
<dependency>
    <groupId>org.springframework.security</groupId>
    <artifactId>spring-security-config</artifactId>
    <version>4.2.10.RELEASE</version>
</dependency>

<!-- SpringSecurity标签库 -->
<dependency>
    <groupId>org.springframework.security</groupId>
    <artifactId>spring-security-taglibs</artifactId>
    <version>4.2.10.RELEASE</version>
</dependency>
```

* 配置过滤器

这里注意一下：

* webapp目录是与java、resources同级，而不是在resources目录之下
* 在配置了springSecurityFilterChain之后，要在spring-mvc.xml下扫描对应的包，加入你的controller和security在不同的包，则需要分别扫描，然后在web.xml中加载spring-mvc.xml，否则会报错：NoSuchBeanDefinitionException: No bean named 'springSecurityFilterChain`，在spring-mvc.xml扫描如下
```
<!--    配置controller扫描-->
<context:component-scan base-package="com.muzimz.funding.controller"></context:component-scan>
<context:component-scan base-package="com.muzimz.funding.security"></context:component-scan>
```

SpringSecurity使用的是过滤器Filter而不是拦截器Interceptor，意味着SpringSecurity
能够管理的不仅仅是 SpringMVC 中的 handler 请求，还包含 Web 应用中所有请求。比如：
项目中的静态资源也会被拦截，从而进行权限控制。
```
<!-- SpringSecurity 的 Filter -->
<filter>
	<filter-name>springSecurityFilterChain</filter-name>
	<filter-class>org.springframework.web.filter.DelegatingFilterProxy</filter-class>
</filter>
<filter-mapping>
	<filter-name>springSecurityFilterChain</filter-name>
	<url-pattern>/*</url-pattern>
</filter-mapping>
```

* 加入配置类

需要继承**WebSecurityConfigurerAdapter**
```
@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true)      // 开启全局扫描配置，是的Controller类可以使用@PreAuthority、@PostAuthority、@PreFilter、@PostFilter 生效
public class WebAppSecurityConfig extends WebSecurityConfigurerAdapter {
}
```

以上配置完成之后：
所有请求都被 SpringSecurity 拦截，要求登录才可以访问。静态资源也都被拦截，要求登录。登录失败有错误提示。

配置好后，我们访问任意路径的资源，都会被拦截到内置的登录页面。
我们来进行一些简单的测试

### 测试一：放行一些资源（重写configure(HttpSecurity security)）

```
security.authorizeRequests()
            .antMatchers("/layui/**", "/index.jsp").permitAll() // 表示该目录下的所有资源放行
            .anyRequest().authenticated();  // 表示除了上述放行的资源之外，其他拦截
```
上述配置之后，我们访问index.jsp可以被放行，但是可能加载不到其他的静态资源，我们需要在spring-mvc.xml中配置如下来放行
```
# 方法一：
<mvc:default-servlet-handler/>
# 方法二：
<mvc:resources mapping="" location=""></mvc:resources>
```

### 测试二：未认证的情况下跳转到对应的登录页面

默认的情况下，未认证会出现`HTTP Status 403 - Access Denied`，我们可以将其更改为未认证跳转到登录页面（在configure(HttpSecurity security)中配置）

```
.and()
.formLogin()
.loginPage("/index.jsp")                 // 指定我们自定义的登录页面
.loginProcessingUrl("/do/login.html")	// 指定提交登录表单的地址（form表单中的action）
.usernameParameter("loginAcct")			// 定制登录账号的请求参数名
.passwordParameter("userPswd")			// 定制登录密码的请求参数名
.defaultSuccessUrl("/main.html")		// 登录成功后前往的地址
```