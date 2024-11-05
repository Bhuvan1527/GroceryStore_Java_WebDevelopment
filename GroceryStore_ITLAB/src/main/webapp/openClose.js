/**
 * 
 */

function formclose(secId) {
	document.getElementById(secId).style.display = "none";
}

function displayForm(secId) {
	document.getElementById(secId).style.display = "block";
}


let slideIndex = 1;
showSlides(slideIndex);

// Next/previous controls
function plusSlides(n) {
	showSlides(slideIndex += n);
}

// Thumbnail image controls
function currentSlide(n) {
	showSlides(slideIndex = n);
}

function showSlides(n) {
	let i;
	let slides = document.getElementsByClassName("mySlides");
	let dots = document.getElementsByClassName("dot");
	if (n > slides.length) { slideIndex = 1 }
	if (n < 1) { slideIndex = slides.length }
	for (i = 0; i < slides.length; i++) {
		slides[i].style.display = "none";
	}
	for (i = 0; i < dots.length; i++) {
		dots[i].className = dots[i].className.replace(" active", "");
	}
	slides[slideIndex - 1].style.display = "block";
	dots[slideIndex - 1].className += " active";
}


function showItems() {
	showPages();
	const xhttp = new XMLHttpRequest();
	let count = document.getElementById('item_count').value;
	let searchItem = document.forms['searchForm']['searchItem'].value;
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			document.getElementById('groceryItemsDiv').innerHTML = this.responseText;
		}
	};
	xhttp.open('GET', "SearchItem.jsp?count=" + count + "&searchItem=" + searchItem, true);
	xhttp.send();
}

function nextItems(pageNum) {
	const xhttp = new XMLHttpRequest();
	let count = document.getElementById('item_count').value;
	let searchItem = document.forms['searchForm']['searchItem'].value;
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			document.getElementById('groceryItemsDiv').innerHTML = this.responseText;
		}
	};
	xhttp.open('GET', "SearchItem.jsp?count=" + count + "&searchItem=" + searchItem + "&pageCount=" + pageNum, true);
	xhttp.send();
}

function showPages() {
	const xhttp = new XMLHttpRequest();
	let count = document.getElementById('item_count').value;
	let searchItem = document.forms['searchForm']['searchItem'].value;
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			document.getElementById('pagination').innerHTML = this.responseText;
		}
	};
	xhttp.open('GET', "pagination.jsp?count=" + count + "&searchItem=" + searchItem, true);
	xhttp.send();
}

function deleteCartItem(id) {
	const xhttp1 = new XMLHttpRequest();
	xhttp1.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			document.getElementById('cart-list').innerHTML = this.responseText;
		}
	};
	console.log(id);
	xhttp1.open('GET', "CartOperation2?itemId=" + id);
	xhttp1.send();
}
function showCart() {
	const xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			document.getElementById('cart-list').innerHTML = this.responseText;
		}
	};
	xhttp.open('GET', "CartOperation");
	xhttp.send();
	displayForm('cart');
}


function loginValidate() {
	let lerr = document.getElementById("loginErr");
	lerr.innerHTML = "";
	let usr = document.forms['loginForm']['loginUsrname'].value;
	const re = new RegExp('^[a-zA-Z_][^-+/*;:\'\"]*$');
	if (!re.test(usr)) {
		lerr.innerHTML = "Invalid User Name.";
		return false;
	}
	return true;
}

function signUpValidate() {
	let ser = document.getElementById("signupErr");
	ser.innerHTML = "";
	const re1 = new RegExp('^[a-zA-Z_][^-+/*;:\'\"]*$');
	const re2 = new RegExp('^[^\'\"]*$');
	const re3 = new RegExp('^[a-zA-Z][a-zA-Z ]*$');
	let usr = document.forms['signUpForm']['signUpUsrname'].value;
	let pass = document.forms['signUpForm']['signUpPasswd'].value;
	let name = document.forms['signUpForm']['signUpname'].value;
	//console.log(usr+" "+pass+" "+name);
	if (!re1.test(usr)) {
		ser.innerHTML += "Invalid User Name <br>";
		//console.log("Usrname err");
	}
	if (!re2.test(pass) || pass.length < 8) {
		ser.innerHTML += "Invalid Password<br>";
		//console.log("password err");
	}
	if (!re3.test(name)) {
		ser.innerHTML += "Name should contain only alphabet and white spaces<br>";
		//console.log("Name err");
	}

	if (ser.innerHTML.length == 0) {
		return true;
	}
	return false;
}

function addItemValidate(){
	let ser = document.getElementById('add-item-err');
	ser.innerHTML = "";
	let item_name = document.forms['add-item']['add-item-name'].value;
	let item_cat = document.forms['add-item']['add-item-category'].value;
	let item_qty = document.forms['add-item']['add-item-qty'].value;
	let item_price = Number(document.forms['add-item']['add-item-price'].value);
	
	console.log(item_name+" "+ item_cat+" "+item_qty+" "+item_price);
	
	if(item_cat == "default"){
		ser.innerHTML += "Please select a category<br>";
	}
	if(item_qty < 0){
		ser.innerHTML += "Please Enter a valid quantity.<br>";
	}
	if(Number.isNaN(item_price) || item_price <= 0){
		ser.innerHTML += "Please Enter a Valid Price.<br>";
	}
	
	if(ser.innerHTML.length == 0){
		return true;
	}
	return false;
}

function addCartCheck(){
	let ser = document.getElementById('cart-err');
	ser.innerHTML = "";
	let cart_qty = Number(document.forms['cart-form']['quantity'].value);
	if(cart_qty <= 0){
		ser.innerHTML = "A enter a positive quantity";
	}
	if(ser.innerHTML.length == 0){
		return true;
	}
	return false;
}
