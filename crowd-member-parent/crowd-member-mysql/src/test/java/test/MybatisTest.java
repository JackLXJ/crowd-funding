package test;

import com.muzimz.crowd.entity.po.MemberPO;
import com.muzimz.crowd.MysqlApplicaton;
import com.muzimz.crowd.entity.vo.DetailProjectVO;
import com.muzimz.crowd.entity.vo.PortalTypeVO;
import com.muzimz.crowd.mapper.MemberPOMapper;
import com.muzimz.crowd.mapper.ProjectPOMapper;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.test.context.junit4.SpringRunner;

import javax.sql.DataSource;
import java.sql.Connection;
import java.util.List;

@SpringBootTest(classes = MysqlApplicaton.class)
@RunWith(SpringRunner.class)
public class MybatisTest {

    @Autowired
    private DataSource dataSource;

    @Autowired
    private MemberPOMapper memberPOMapper;

    @Autowired
    private ProjectPOMapper projectPOMapper;

    private Logger logger = LoggerFactory.getLogger(MybatisTest.class);

    @Test
    public void testLoadTypeData() {
        DetailProjectVO detailProjectVO = projectPOMapper.selectDetailProjectVO(6);
        System.out.println(detailProjectVO);
//        List<PortalTypeVO> portalTypeVOS = projectPOMapper.selectPortalTypeVOList();
//        for (PortalTypeVO portalTypeVO: portalTypeVOS) {
//            System.out.println(portalTypeVO);
//        }
    }

    @Test
    public void testMapper() {
        BCryptPasswordEncoder bCryptPasswordEncoder = new BCryptPasswordEncoder();
        String encode = bCryptPasswordEncoder.encode("510087153");
        MemberPO memberPO = new MemberPO(null, "taoye", encode, "涛爷", "510087153@qq.com", 1, 1, "涛爷", "510087153", 2);
        memberPOMapper.insert(memberPO);
    }

    @Test
    public void testConnection() throws Exception {
        Connection connection = dataSource.getConnection();
        logger.debug(connection.toString() + "测试数据库的连接");
    }

}
