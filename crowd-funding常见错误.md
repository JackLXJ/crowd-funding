[TOC]

# crowd-funding常见错误

## generatorConfig.xml中地址找不到

http://mybatis.org/dtd/mybatis-generator-config_1_0.dtd爆红

settings -> schemas and DTDs -> url选择上面的地址 -> Location选择**C:/Users/M/.m2/repository/org/mybatis/generator/mybatis-generator-core/1.3.2/mybatis-generator-core-1.3.2.jar!/org/mybatis/generator/config/xml/mybatis-generator-config_1_0.dtd**
注意以上本地dtd地址要自己一个个点，而不是复制粘贴

## idea下逆向工程

配置好后，打开右边的maven -> plugins -> mybatis-genator -> mybatis-genator:generator

## idea @Override is not allowed when implementing interface method

https://blog.csdn.net/shenya2/article/details/50460447

## idea中applicationContext-trans.xml中的Cannot resolve bean 'dataSource'...的问题解决

https://www.cnblogs.com/rgever/p/10101136.html

## XXXXXXXX\jsqlparser-0.9.1.jar时出错;：invalid LOC header (bad signature)

在jar包下载的时候出错了，将仓库中的jar包删除然后重新在idea中刷新即可

## IDEA Error:java: Compilation failed: internal java compiler error

解决办法很简单：File-->Setting...-->Build,Execution,Deployment-->Compiler-->Java Compiler 设置相应Module的target bytecode version的合适版本（跟你jkd版本一致），这里我改成1.8版本的。

## SSM测试出现错误说：没有找到Bean

```
@ContextConfiguration(locations = {"classpath:spring-persist-mybatis.xml", "classpath:spring-persist-tx.xml"})
@RunWith(SpringJUnit4ClassRunner.class)
public class CrowdTest {

    @Autowired
    private AdminMapper adminMapper;

    @Test
    public void testConnection() throws Exception {
        Admin admin = new Admin(1, "sdasdsa", "dasdsa", "fasfdf", "fadfdf", "fdgsfg");
        int insert = adminMapper.insert(admin);
        System.out.println("插入数据：" + insert);ss
    }
}
```

注意：@ContextConfiguration不能采用spring-*.xml的形式进行配置扫描包

## 通过maven中的tomcat来运行web项目

## 执行mvn complie 报错 source-1.5 中不支持 diamond运算符

配置maven-compiler-plugin的版本为1.8

```
<plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-compiler-plugin</artifactId>
    <version>3.3</version>
    <configuration>
        <source>1.8</source>
        <target>1.8</target>
    </configuration>
</plugin>
```

## 在controller中传入数组参数报错

nested exception is org.apache.ibatis.binding.BindingException: Parameter 'roleIdList' not found. Available parameters are [0, 1, param1, param2]

在AdminMapper.java与AdminMapper.xml过程中出现如上错误，主要因为在解析参数时失败，在mapper层中的接口参数配置@Param注解即可：

```
// 修改前
void insertNewRelationship(Integer adminId, List<Integer> roleIdList);
// 修改后
void insertNewRelationship(@Param("adminId") Integer adminId, @Param("roleIdList") List<Integer> roleIdList);
```

## 引入之后Spring Security相关依赖之后可能出现的问题

* java.lang.ClassNotFoundException: org.springframework.web.context.ContextLoaderListener以及CharacterEncodingFilter等相关组件加载不到

解决办法：

在我们自定义自己的WebAppSecurityConfig并继承WebSecurityConfigurerAdapter的时候，需要加上EnableGlobalMethodSecurity注解表示示启用全局方法权限管理功能

```
@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true)
public class WebAppSecurityConfig extends WebSecurityConfigurerAdapter {

}
```

* org.springframework.beans.factory.NoSuchBeanDefinitionException: No bean named 'springSecurityFilterChain' is defined

主要是因为ContextLoaderListener 初始化后，springSecurityFilterChain 就在 ContextLoaderListener创建的 IOC 容器中查找所需要的 bean，但是我们没有在 ContextLoaderListener 的 IOC 容器中扫描 SpringSecurity 的配置类，所以 springSecurityFilterChain 对应的 bean 找不到。

解决办法：

在web.xml中将 ContextLoaderListener 取消，原本由 ContextLoaderListener 读取的 Spring 配置文
件交给 DispatcherServlet 负责读取。

```
<servlet>
    <servlet-name>springDispatcherServlet</servlet-name>
    <servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>
    <init-param>
        <param-name>contextConfigLocation</param-name>
    <param-value>classpath:spring-web-mvc.xml,classpath:spring-persist-*.xml</param-value>
    </init-param>
    <load-on-startup>1</load-on-startup>
</servlet>
```

另外在spring-web-mvc.xml配置文件中加上的如下配置：

```
<security:global-method-security jsr250-annotations="enabled" secured-annotations="enabled"/>
```

spring security这部分的坑挺多的，大家注意点，有点耐心去解决。

## com.netflix.zuul.exception.ZuulException: Hystrix Readed time out

在Zuul网关中的application.yml内配置zuul和ribbon的超时时间，不使用默认的超时时间

```
zuul:
  host:
    connect-timeout-millis: 15000 #HTTP连接超时大于Hystrix的超时时间
    socket-timeout-millis: 60000   #socket超时
  routes:
    aigouUser.serviceId: user-provider
    aigouUser.path: /user/**
    aigouProduct.serviceId: aigou-product
    aigouProduct.path: /product/**
  ignored-services: "*"
  prefix: /aigou
ribbon:        #设置ribbon的超时时间小于zuul的超时时间
  ReadTimeout: 10000
  ConnectTimeout: 10000
```
