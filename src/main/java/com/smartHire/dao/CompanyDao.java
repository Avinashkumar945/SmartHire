package com.smartHire.dao;

import java.util.List;
import java.util.Optional;

import com.smartHire.model.Company;

public interface CompanyDao {
    Company save(Company comp) ;
    Company update(Company comp);
    Optional<Company> findByid(Long id);
    Optional<Company> findByUserId(Long userId);
    List<Company> findAll();
    List<Company> findUnverified();
    void verify(Long companyId);
    boolean existsByName(String name);
}
