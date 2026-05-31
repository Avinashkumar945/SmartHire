package com.smartHire.dao;

import java.util.List;
import java.util.Optional;

import com.smartHire.model.User;

public interface UserDao {
  User save(User user);
  
  Optional<User> findByEmail(String email);
  
  Optional<User> findById(Integer id);
  
  List<User> findAll();
  
  void updateStatus(Integer userId, User.Status status);
  
  boolean existsByEmail(String email);
  
}
