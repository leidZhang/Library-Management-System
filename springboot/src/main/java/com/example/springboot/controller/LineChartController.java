package com.example.springboot.controller;

import com.example.springboot.common.Result;
import com.example.springboot.service.ILineChartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@CrossOrigin
@RestController
@RequestMapping("/lineChart")
public class LineChartController {
    @Autowired
    ILineChartService service;

    @GetMapping("getLineChart/{range}")
    public Result getLineChart(@PathVariable String range) {
        return Result.success(service.getLineChart(range));
    }
}
