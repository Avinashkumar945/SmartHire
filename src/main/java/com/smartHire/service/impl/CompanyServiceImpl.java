package com.smartHire.service.impl;

import java.util.Optional;

import com.smartHire.dao.CompanyDao;
import com.smartHire.dao.impl.CompanyDaoImpl;
import com.smartHire.exception.AppException;
import com.smartHire.model.Company;
import com.smartHire.service.companyService;

public class CompanyServiceImpl implements companyService {
    CompanyDao dao=new CompanyDaoImpl();
	@Override
	public Company saveCompany(Company comp) {
		  if(dao.existsByName(comp.getName())) {
			  throw new AppException(
			            "company already exists for this name."+comp.getName(), 409);
		  }
		 return dao.save(comp);
	}
	@Override
	public Company alreadySavedCompanybyUserId(Long id) {
		     
		  Optional<Company>  savedCompany =dao.findByUserId(id);
		  if(savedCompany.isEmpty()) {
			  throw new AppException("company details are not saved yet", 500);
		  }
		return savedCompany.get();
	}

}
