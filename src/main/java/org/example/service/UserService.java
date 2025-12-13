package org.example.service;

import org.example.model.User;
import org.example.repository.UserRepository;

import java.util.Optional;

public class UserService {

    private final UserRepository userRepository;

    public UserService() {
        this.userRepository = new UserRepository();
    }

    public Optional<User> findUserByEmailAndPwd(String email, String pwd) {
        return userRepository.findUserByEmailAndPwd(email,pwd);
    }

    public boolean registerUser(String email, String password, String fullname) {
        User u = new User();
        u.setEmail(email);
        u.setPassword(password);
        u.setFullname(fullname);
        u.setRole("USER");
        return userRepository.addUser(u);
    }
}
