function validateName() {
  let nameEle = document.getElementById("name");
  let name = nameEle.value.trim();
  let nameErr = document.getElementById("name-error");
  let isNameValid = false;
  const nameRegex = /^[a-zA-Z]+( [a-zA-Z]*)*$/;
  if (name === " " || name.length < 3) {
    nameErr.innerHTML = "Must be at least 3 characters";
    nameEle.style.border = "2px solid red";
    nameErr.style.display = "inline";
    isNameValid = false;
  } else if (!nameRegex.test(name)) {
    nameErr.innerHTML = "Must contain only alphabets";
    nameEle.style.border = "2px solid red";
    nameErr.style.display = "inline";
    isNameValid = false;
  } else {
    nameErr.style.display = "none";
    nameEle.style.border = "2px solid green";
    isNameValid = true;
  }
  return isNameValid;
}

function validateEmail() {
  let emailEle = document.getElementById("email");
  let email = emailEle.value.trim();
  let emailErr = document.getElementById("email-error");
  let isEmailValid = false;
  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  if (email === " " || email.length < 1) {
    emailErr.innerHTML = "Email cannot be empty";
    emailEle.style.border = "2px solid red";
    emailErr.style.display = "inline";
    isEmailValid = false;
  } else if (!emailRegex.test(email)) {
    emailErr.innerHTML = "Must be in the format <br> of abc@example.com";
    emailEle.style.border = "2px solid red";
    emailErr.style.display = "inline";
    isEmailValid = false;
  } else {
    emailErr.style.display = "none";
    emailEle.style.border = "2px solid green";
    isEmailValid = true;
  }
  return isEmailValid;
}

function validateContactNo() {
  let contactEle = document.getElementById("contactno");
  let contact = contactEle.value.trim();
  let contactErr = document.getElementById("contact-error");
  let iscontactValid = false;
  const contactRegex = /^\d{10}$/;
  if (contact === " ") {
    contactErr.innerHTML = "Contact Number cannot be empty";
    contactEle.style.border = "2px solid red";
    contactErr.style.display = "inline";
    iscontactValid = false;
  } else if (!contactRegex.test(contact)) {
    contactErr.innerHTML = "Should contaion only 10 digits";
    contactEle.style.border = "2px solid red";
    contactErr.style.display = "inline";
    iscontactValid = false;
  } else {
    contactErr.style.display = "none";
    contactEle.style.border = "2px solid green";
    iscontactValid = true;
  }
  return iscontactValid;
}

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
  }
}

function validateConfirmPassword() {
  var password = document.getElementById('password');
  var cpassword = document.getElementById('confirmPwd');
  var confirmPasswordError = document.getElementById('cpassword-error');
  if (cpassword.value != password.value) {
    confirmPasswordError.innerHTML = "Passwords do not match";
    confirmPasswordError.style.display = 'inline';
    cpassword.style.border = "2px solid red";
    return false;
  } else {
    confirmPasswordError.style.display = 'none';
    cpassword.style.border = "2px solid green";
    return true;
  }
}

function validateAddress() {
  var address = document.getElementById('address');
  var addressError = document.getElementById('address-error');
  if (address.value.trim() === '') {
    addressError.innerHTML = "Address cannot be empty";
    addressError.style.display = 'inline';
    address.style.border = "2px solid red";
    return false;
  } else {
    addressError.style.display = 'none';
    address.style.border = "2px solid green";
    return true;
  }
}

function validateForm() {
  if (validateName() && validateEmail() && validateContactNo() && validateAddress() && validatePassword() && validateConfirmPassword()) {
    return true;
  }
  else {
    return false;
  }
}

function validateUpdateForm(){
  if (validateName() && validateEmail() && validateContactNo() && validateAddress()) {
    return true;
  }
  else {
    return false;
  }
}

function validateChangePassword(){
  if(validatePassword() && validateConfirmPassword()){
    return true;
  }else{
    return false;
  }
}