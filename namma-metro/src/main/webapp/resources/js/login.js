function validatePassword() {
    var password = document.getElementById('password');
    var passwordError = document.getElementById('password-error');
    if (password.value.length < 8) {
        passwordError.innerHTML = "Please provide a valid password";
        password.style.border = "2px solid red";
        passwordError.style.display = 'inline';
        return false;
    } else {
        password.style.border = "2px solid green";
        passwordError.style.display = 'none';
        return true;
    } d
}

function validateLoginId() {
    let loginEle = document.getElementById("loginId");
    let login = loginEle.value.trim();
    let loginErr = document.getElementById("login-error");
    let isLoginIdValid = false;
    const nameRegex = /^[a-zA-Z]+( [a-zA-Z]*)*$/;
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (login === " " || login.length < 3) {
        loginErr.innerHTML = "Must be at least 3 characters";
        loginEle.style.border = "2px solid red";
        loginErr.style.display = "inline";
        isLoginIdValid = false;
    } else if (!nameRegex.test(login) && !emailRegex.test(login)) {
        loginErr.innerHTML = "Incorrect username or email";
        loginEle.style.border = "2px solid red";
        loginErr.style.display = "inline";
        isLoginIdValid = false;
    } else {
        loginErr.style.display = "none";
        loginEle.style.border = "2px solid green";
        isLoginIdValid = true;
    }
    return isLoginIdValid;
}

function validateForm() {
    if (validateLoginId() && validatePassword()) {
        return true;
    }
    else {
        return false;
    }
}