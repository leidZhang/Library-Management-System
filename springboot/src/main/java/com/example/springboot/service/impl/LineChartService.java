package com.example.springboot.service.impl;

import cn.hutool.core.date.DateField;
import cn.hutool.core.date.DateTime;
import cn.hutool.core.date.DateUtil;
import com.example.springboot.entity.Borrow;
import com.example.springboot.entity.Retern;
import com.example.springboot.mapper.BorrowMapper;
import com.example.springboot.mapper.ReternMapper;
import com.example.springboot.mapper.po.BorrowReternCountPO;
import com.example.springboot.service.ILineChartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class LineChartService implements ILineChartService {
    @Autowired
    BorrowMapper borrowMapper;

    @Autowired
    ReternMapper reternMapper;

    @Override
    public Object getLineChart(String range) {
        Map<String, Object> map = new HashMap<>();
        List<DateTime> dateRange;
        Date today = new Date();
        // 4 conditions
        switch (range) {
            case "week":
                dateRange = DateUtil.rangeToList(DateUtil.offsetDay(today, -6), today, DateField.DAY_OF_WEEK);
                break;
            case "month":
                dateRange = DateUtil.rangeToList(DateUtil.offsetDay(today, -29), today, DateField.DAY_OF_MONTH);
                break;
            case "month2":
                dateRange = DateUtil.rangeToList(DateUtil.offsetDay(today, -59), today, DateField.DAY_OF_MONTH);
                break;
            case "month3":
                dateRange = DateUtil.rangeToList(DateUtil.offsetDay(today, -89), today, DateField.DAY_OF_MONTH);
                break;
            default:
                dateRange = new ArrayList<>();
        }
        // get data
        List<String> dateRangeStr = my_dateTimeToDateStr(dateRange);
        List<BorrowReternCountPO> borrowData = borrowMapper.countByCDate(range);
        List<BorrowReternCountPO> reternData = reternMapper.countByADate(range);
        // insert data
        map.put("date", dateRangeStr); // xAxis data
        map.put("borrows", countList(borrowData, dateRangeStr)); // yAxis data borrow
        map.put("reterns", countList(reternData, dateRangeStr)); // yAxis data retern

        return map;
    }

    private List<String> my_dateTimeToDateStr(List<DateTime> dateRange) {
        List<String> strList = new ArrayList<>();
        if(dateRange.isEmpty()) {
            return strList;
        }
        for(DateTime dateTime: dateRange) {
            String strDate = DateUtil.formatDate(dateTime);
            strList.add(strDate);
        }
        return strList;
    }

    private List<Integer> countList(List<BorrowReternCountPO> poList, List<String> dateRangeStr) { // get some help form others
        List<Integer> intList = new ArrayList<>();
        if(poList.isEmpty()) {
            return intList;
        }
        for (String date: dateRangeStr) {
            // get count in each po, if po.count == null, let count = 0, else let count = po.count
            Integer count = poList.stream().filter(po -> date.equals(po.getDate())).map(BorrowReternCountPO::getCount).findFirst().orElse(0);
            intList.add(count);
        }
        return intList;
    }
}
