package com.smartHire.service;

import com.smartHire.model.Company;

public interface companyService {
   Company saveCompany(Company comp);
   Company alreadySavedCompanybyUserId(Long comp);
}
