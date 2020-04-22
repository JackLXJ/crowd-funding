package com.muzimz.crowd.handler;

import com.muzimz.crowd.api.MysqlRemoteService;
import com.muzimz.crowd.constant.CrowdConstant;
import com.muzimz.crowd.entity.vo.PortalTypeVO;
import com.muzimz.crowd.util.ResultEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
public class PortalHandler {

    @Autowired
    private MysqlRemoteService mysqlRemoteService;

    @RequestMapping(value = "/")
    public String showPortalPage(Model model) {

        ResultEntity<List<PortalTypeVO>> portalTypeProjectDataRemote = mysqlRemoteService.getPortalTypeProjectDataRemote();

        String result = portalTypeProjectDataRemote.getResult();
        if (ResultEntity.SUCCESS.equals(result)) {
            List<PortalTypeVO> list = portalTypeProjectDataRemote.getData();
            model.addAttribute(CrowdConstant.ATTR_NAME_PORTAL_DATA, list);
        }

        return "portal";
    }
}
