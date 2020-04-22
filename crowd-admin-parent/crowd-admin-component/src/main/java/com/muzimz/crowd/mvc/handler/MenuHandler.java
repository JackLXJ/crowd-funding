package com.muzimz.crowd.mvc.handler;

import com.muzimz.crowd.entity.Menu;
import com.muzimz.crowd.service.api.MenuService;
import com.muzimz.crowd.util.ResultEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class MenuHandler {

    @Autowired
    private MenuService menuService;

    @ResponseBody
    @RequestMapping(value = "/menu/remove.json")
    public ResultEntity<String> removeMenu(@RequestParam(value = "id") Integer id) {
        menuService.removeMenu(id);
        return ResultEntity.successWithData("节点删除成功");
    }

    @RequestMapping("/menu/update.json")
    @ResponseBody
    public ResultEntity<String> upateMenu(Menu menu) {
        menuService.updateMenu(menu);
        return ResultEntity.successWithData("节点更新成功");
    }

    @ResponseBody
    @RequestMapping(value = "/menu/save.json")
    public ResultEntity<String> saveMenu(Menu menu) {
        menuService.saveMenu(menu);
        return ResultEntity.successWithData("菜单添加成功！！！");
    }

    @ResponseBody
    @RequestMapping(value = "/menu/get/whole/tree.json")
    public ResultEntity<Menu> getWholeTreeNew() {
        List<Menu> menuList = menuService.getAll();

        Menu root = null;

        Map<Integer, Menu> menuMap = new HashMap<Integer, Menu>();
        for (Menu menu : menuList) {
            menuMap.put(menu.getId(), menu);
        }

        for (Menu menu : menuList) {
            Integer pid = menu.getPid();
            if (pid == null) {
                root = menu;
                continue;
            }
            Menu father = menuMap.get(pid);
            father.getChildren().add(menu);
        }
        return ResultEntity.successWithData(root);
    }
}
