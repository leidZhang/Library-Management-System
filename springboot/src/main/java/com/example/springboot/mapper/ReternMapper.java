package com.example.springboot.mapper;

import com.example.springboot.controller.request.ReternPageRequest;
import com.example.springboot.entity.Retern;
import com.example.springboot.mapper.po.BorrowReternCountPO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ReternMapper {
    List<Retern> list();

    List<Retern> listByCondition(ReternPageRequest request);

    void deleteByEmailAndISBN(String email, String isbn);

    void save(Retern retern);

    List<Retern> selectByEmailAndISBN(String email, String isbn);

    List<BorrowReternCountPO> countByADate(String range);
}
