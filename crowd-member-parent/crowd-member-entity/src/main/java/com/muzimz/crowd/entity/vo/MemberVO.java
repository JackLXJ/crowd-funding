package com.muzimz.crowd.entity.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 用来封装注册的表单数据
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class MemberVO {

    private String loginacct;
    private String userpswd;
    private String username;
    private String email;
    private String phoneNum;
    private String code;


}
