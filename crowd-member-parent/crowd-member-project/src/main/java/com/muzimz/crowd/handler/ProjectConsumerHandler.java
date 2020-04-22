package com.muzimz.crowd.handler;

import com.muzimz.crowd.api.MysqlRemoteService;
import com.muzimz.crowd.constant.CrowdConstant;
import com.muzimz.crowd.entity.vo.*;
import com.muzimz.crowd.file.FastDFSFile;
import com.muzimz.crowd.util.CrowdUtil;
import com.muzimz.crowd.util.FastDFSUtil;
import com.muzimz.crowd.util.ResultEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@Controller
public class ProjectConsumerHandler {

    @Autowired
    private MysqlRemoteService mysqlRemoteService;

    @RequestMapping("/get/project/detail/{projectId}")
    public String getProjectDetail(@PathVariable("projectId") Integer projectId, Model model) {

        ResultEntity<DetailProjectVO> resultEntity = mysqlRemoteService.getDetailProjectVORemote(projectId);

        if(ResultEntity.SUCCESS.equals(resultEntity.getResult())) {
            DetailProjectVO detailProjectVO = resultEntity.getData();

            model.addAttribute("detailProjectVO", detailProjectVO);
        }
        return "project-show-detail";
    }

    @PostMapping(value = "/upload")
    @ResponseBody
    public ResultEntity<String> upload(@RequestParam(value = "file") MultipartFile file) throws Exception {

        FastDFSFile fastDFSFile = new FastDFSFile(
                file.getOriginalFilename(),
                file.getBytes(),
                StringUtils.getFilenameExtension(file.getOriginalFilename())// 获取文件扩展名
        );
        return ResultEntity.successWithData(FastDFSUtil.upload(fastDFSFile));
//        String[] uploads = FastDFSUtil.upload(fastDFSFile);
        // url = http://192.168.220.201:8080/group1/M00/00/00/dsadasdasda.jpeg
//        String url = "http://192.168.220.201:8080/" + uploads[0] + "/" + uploads[1];
//        return new Result(true, StatusCode.OK, "上传成功", url);
    }

    @RequestMapping("/create/confirm")
    public String saveConfirm(ModelMap modelMap, HttpSession session, MemberConfirmInfoVO memberConfirmInfoVO) {

        // 1.从Session域读取之前临时存储的ProjectVO对象
        ProjectVO projectVO = (ProjectVO) session.getAttribute(CrowdConstant.ATTR_NAME_TEMPLE_PROJECT);

        // 2.如果projectVO为null
        if(projectVO == null) {
            throw new RuntimeException(CrowdConstant.MESSAGE_TEMPLE_PROJECT_MISSING);
        }

        // 3.将确认信息数据设置到projectVO对象中
        projectVO.setMemberConfirmInfoVO(memberConfirmInfoVO);

        // 4.从Session域读取当前登录的用户
        MemberLoginVO memberLoginVO = (MemberLoginVO) session.getAttribute(CrowdConstant.ATTR_NAME_LOGIN_MEMBER);

        Integer memberId = memberLoginVO.getId();

        // 5.调用远程方法保存projectVO对象
        ResultEntity<String> saveResultEntity = mysqlRemoteService.saveProjectVORemote(projectVO, memberId);

        // 6.判断远程的保存操作是否成功
        String result = saveResultEntity.getResult();
        if(ResultEntity.FAILED.equals(result)) {

            modelMap.addAttribute(CrowdConstant.ATTR_NAME_MESSAGE, saveResultEntity.getMessage());

            return "project-confirm";
        }

        // 7.将临时的ProjectVO对象从Session域移除
        session.removeAttribute(CrowdConstant.ATTR_NAME_TEMPLE_PROJECT);

        // 8.如果远程保存成功则跳转到最终完成页面
        return "redirect:http://www.crowd.com/project/create/success";
    }

    @ResponseBody
    @RequestMapping("/create/save/return.json")
    public ResultEntity<String> saveReturn(ReturnVO returnVO, HttpSession session) {

        try {
            // 1.从session域中读取之前缓存的ProjectVO对象
            ProjectVO projectVO = (ProjectVO) session.getAttribute(CrowdConstant.ATTR_NAME_TEMPLE_PROJECT);

            // 2.判断projectVO是否为null
            if(projectVO == null) {
                return ResultEntity.failed(CrowdConstant.MESSAGE_TEMPLE_PROJECT_MISSING);
            }

            // 3.从projectVO对象中获取存储回报信息的集合
            List<ReturnVO> returnVOList = projectVO.getReturnVOList();

            // 4.判断returnVOList集合是否有效
            if(returnVOList == null || returnVOList.size() == 0) {

                // 5.创建集合对象对returnVOList进行初始化
                returnVOList = new ArrayList<>();
                // 6.为了让以后能够正常使用这个集合，设置到projectVO对象中
                projectVO.setReturnVOList(returnVOList);
            }

            // 7.将收集了表单数据的returnVO对象存入集合
            returnVOList.add(returnVO);

            // 8.把数据有变化的ProjectVO对象重新存入Session域，以确保新的数据最终能够存入Redis
            session.setAttribute(CrowdConstant.ATTR_NAME_TEMPLE_PROJECT, projectVO);

            // 9.所有操作成功完成返回成功
            return ResultEntity.successWithoutData();
        } catch (Exception e) {
            e.printStackTrace();

            return ResultEntity.failed(e.getMessage());
        }

    }

    // JavaScript代码：formData.append("returnPicture", file);
    // returnPicture是请求参数的名字
    // file是请求参数的值，也就是要上传的文件
    @ResponseBody
    @RequestMapping("/create/upload/return/picture.json")
    public ResultEntity<String> uploadReturnPicture(

            // 接收用户上传的文件
            @RequestParam("returnPicture") MultipartFile returnPicture) throws Exception {

        // 1.执行文件上传
        FastDFSFile fastDFSFile = new FastDFSFile(
                returnPicture.getOriginalFilename(),
                returnPicture.getBytes(),
                StringUtils.getFilenameExtension(returnPicture.getOriginalFilename())
        );
        System.out.println(FastDFSUtil.upload(fastDFSFile));
        return ResultEntity.successWithData(FastDFSUtil.upload(fastDFSFile));
    }


    @RequestMapping(value = "/create/project/information")
    public String saveProjectBasicInfo(ProjectVO projectVO,
                                       @RequestParam("headerPicture") MultipartFile headerPicture,
                                       @RequestParam("detailPictureList") List<MultipartFile> detailPictureList,
                                       HttpSession session,
                                       ModelMap modelMap) throws Exception {
        boolean headerPictureEmpty = headerPicture.isEmpty();
        if (headerPictureEmpty) {
            // 2.如果没有上传头图则返回到表单页面并显示错误消息
            modelMap.addAttribute(CrowdConstant.ATTR_NAME_MESSAGE, CrowdConstant.MESSAGE_HEADER_PIC_EMPTY);
            return "project-launch";
        }
        FastDFSFile fastDFSFile = new FastDFSFile(
                headerPicture.getOriginalFilename(),
                headerPicture.getBytes(),
                StringUtils.getFilenameExtension(headerPicture.getOriginalFilename())
        );
        String headerPicturePath = FastDFSUtil.upload(fastDFSFile);
        System.out.println(headerPicturePath);
        if (headerPicturePath != null) {
            projectVO.setHeaderPicturePath(headerPicturePath);
        }else {
            // 7.如果上传失败则返回到表单页面并显示错误消息
            modelMap.addAttribute(CrowdConstant.ATTR_NAME_MESSAGE, CrowdConstant.MESSAGE_HEADER_PIC_UPLOAD_FAILED);

            return "project-launch";
        }

        // 二、上传详情图片
        // 1.创建一个用来存放详情图片路径的集合
        List<String> detailPicturePathList = new ArrayList<String>();

        // 2.检查detailPictureList是否有效
        if(detailPictureList == null || detailPictureList.size() == 0) {
            modelMap.addAttribute(CrowdConstant.ATTR_NAME_MESSAGE, CrowdConstant.MESSAGE_DETAIL_PIC_EMPTY);

            return "project-launch";
        }

        for (MultipartFile detailPicture : detailPictureList) {
            if (detailPicture.isEmpty()) {
                // 5.检测到详情图片中单个文件为空也是回去显示错误消息
                modelMap.addAttribute(CrowdConstant.ATTR_NAME_MESSAGE, CrowdConstant.MESSAGE_DETAIL_PIC_EMPTY);

                return "project-launch";
            }
            FastDFSFile detailFastDFS = new FastDFSFile(
                    detailPicture.getOriginalFilename(),
                    detailPicture.getBytes(),
                    StringUtils.getFilenameExtension(detailPicture.getOriginalFilename())
            );
            String detailPicturePath = FastDFSUtil.upload(detailFastDFS);
            System.out.println(detailPicturePath);
            if (detailPicturePath != null) {
                detailPicturePathList.add(detailPicturePath);
            }else {
                // 9.如果上传失败则返回到表单页面并显示错误消息
                modelMap.addAttribute(CrowdConstant.ATTR_NAME_MESSAGE, CrowdConstant.MESSAGE_DETAIL_PIC_UPLOAD_FAILED);

                return "project-launch";
            }
        }
        projectVO.setDetailPicturePathList(detailPicturePathList);
        session.setAttribute(CrowdConstant.ATTR_NAME_TEMPLE_PROJECT, projectVO);

        // 2.以完整的访问路径前往下一个收集回报信息的页面
        return "redirect:http://www.crowd.com/project/return/info/page";
    }

}
