package test;

import com.muzimz.crowd.entity.vo.Employee;

public class LombokTest {

    public static void main(String[] args) {
        Employee employee = new Employee(13, "天行健", 1321.1);
        System.out.println(employee);
    }
}
