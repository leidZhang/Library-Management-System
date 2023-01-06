package com.example.springboot.mapper;

import com.example.springboot.controller.request.BorrowPageRequest;
import com.example.springboot.entity.Borrow;
import com.example.springboot.mapper.po.BorrowReternCountPO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface BorrowMapper {
    List<Borrow> list();

    List<Borrow> listByCondition(BorrowPageRequest request);

    void save(Borrow borrow);

    Borrow getByEmailAndISBN(String email, String isbn, Integer id);

    void updateByEmailAndISBN(Borrow borrow);

    void deleteByEmailAndISBN(String email, String isbn, Integer id);


    List<Borrow> selectByEmailAndISBN(String email, String isbn);


    List<BorrowReternCountPO> countByCDate(String range);
}
