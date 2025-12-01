package org.example.repository;

import org.example.model.User;

import java.util.List;
import java.util.Optional;
import java.util.function.Predicate;

public class UserRepository {

    private static List<User> users = List.of(new User("zribi.mokhles@gmail.com", "123456", "Mokhles Zribi"), new User("zribi.mokhles@sofrecom.com", "123456", "Mokhles Zribi Sof"));

    public UserRepository() {
    }

    public Optional<User> findUserByEmailAndPwd(String email, String pwd) {
        Predicate<User> matchCredentials = user -> user.getEmail().equals(email) && user.getPassword().equals(pwd);
        return users.stream().filter(matchCredentials).findFirst();

    }
}
