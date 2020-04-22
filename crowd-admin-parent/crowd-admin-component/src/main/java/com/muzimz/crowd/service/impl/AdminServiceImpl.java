package com.muzimz.crowd.service.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Objects;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.muzimz.crowd.constant.CrowdConstant;
import com.muzimz.crowd.exception.LoginAcctAlreadyInUseException;
import com.muzimz.crowd.exception.LoginFailedException;
import com.muzimz.crowd.util.CrowdUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.muzimz.crowd.entity.Admin;
import com.muzimz.crowd.entity.AdminExample;
import com.muzimz.crowd.mapper.AdminMapper;
import com.muzimz.crowd.service.api.AdminService;

@Service
public class AdminServiceImpl implements AdminService {

	@Autowired
	private AdminMapper adminMapper;

	@Autowired
	private BCryptPasswordEncoder passwordEncoder;

	@Override
	public PageInfo<Admin> getAdminPage(String keyword, Integer pageNum, Integer pageSize) {
		PageHelper.startPage(pageNum, pageSize);
		List<Admin> admins = adminMapper.selectAdminListByKeyword(keyword);
		Logger logger = LoggerFactory.getLogger(AdminServiceImpl.class);
		logger.info("adminList的全类名是：" + admins.getClass().getName());
		return new PageInfo<Admin>(admins);
	}

	@Override
	public Admin getAdminById(Integer adminId) {
		return adminMapper.selectByPrimaryKey(adminId);
	}

	@Override
	public void updateAdmin(Admin admin) {
		Admin tempAdmin = adminMapper.selectByPrimaryKey(admin.getId());
		admin.setUserPswd(tempAdmin.getUserPswd());
		admin.setCreateTime(tempAdmin.getCreateTime());

		adminMapper.updateByPrimaryKey(admin);

//		admin.setUserPswd(tempAdmin.getUserPswd());
//		admin.setCreateTime(tempAdmin.getCreateTime());
//		AdminExample adminExample = new AdminExample();
//		AdminExample.Criteria criteria = adminExample.createCriteria();
//		adminMapper.updateByExample(admin, adminExample);
	}

	@Override
	public void removeAdminById(Integer adminId) {
		adminMapper.deleteByPrimaryKey(adminId);
	}

	@Override
	public void saveAdminRoleRelationship(Integer adminId,  List<Integer> roleIdList) {
		adminMapper.deleteOLdRelationship(adminId);
		if (roleIdList != null && roleIdList.size() > 0) {
			adminMapper.insertNewRelationship(adminId, roleIdList);
		}
	}

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

	@Override
	public List<Admin> getAll() {
		return adminMapper.selectByExample(new AdminExample());
	}

	@Override
	public Admin getAdminByLoginAcct(String loginAcct, String userPswd) {

		// 1.根据登录账户查询admin对象
		AdminExample adminExample = new AdminExample();
		AdminExample.Criteria criteria = adminExample.createCriteria();
		criteria.andLoginAcctEqualTo(loginAcct);
		List<Admin> admins = adminMapper.selectByExample(adminExample);
//		//2.判断admin对象是否为null
//		if (admins == null || admins.size() == 0) {
//			throw new LoginFailedException(CrowdConstant.MESSAGE_LOGIN_FAILED);
//		}
//		if (admins.size() > 1) {
//			throw new RuntimeException(CrowdConstant.MESSAGE_SYSTEM_ERROR_LOGIN_NOT_UNIQUE);
//		}
//		Admin admin = admins.get(0);
//		// 3.如果admin对象为null则抛异常
//		if (admin == null) {
//			throw new LoginFailedException(CrowdConstant.MESSAGE_LOGIN_FAILED);
//		}
//		// 4.如果admin对象不为null则将数据库密码从admin对象中取出
//		String userPswdDB = admin.getUserPswd();
//		// 5. 将表单提交的明文密码进行加密
//		String userPswdForm = CrowdUtil.md5(userPswd);
//		// 6.将密码进行比较
//		if (!Objects.equals(userPswdDB, userPswdForm)) {
//			// 7. 如果比较结果是不一致的则抛出异常
//			throw new LoginFailedException(CrowdConstant.MESSAGE_LOGIN_FAILED);
//		}
//
//		// 8.如果一直则返回admin对象
		return admins.get(0);
	}
}
