<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>




<!doctype html>
<html lang="en">
    
<head>
    <meta charset="utf-8">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="/web/resources/css/font-awesome.min.css" rel="stylesheet" type="text/css" media="all">
    <link href="/web/resources/css/themify-icons.css" rel="stylesheet" type="text/css" media="all" />
    <link href="/web/resources/css/bootstrap.css" rel="stylesheet" type="text/css" media="all" />
    <link href="/web/resources/css/flexslider.css" rel="stylesheet" type="text/css" media="all" />
    <link href="/web/resources/css/theme-red.css" rel="stylesheet" type="text/css" media="all" />
    <link href="/web/resources/css/custom.css" rel="stylesheet" type="text/css" media="all" />
    <link href="/web/resources/css/lightbox.min.css" rel="stylesheet" type="text/css" media="all" />
    <link href="/web/resources/css/ytplayer.css" rel="stylesheet" type="text/css" media="all" />
    <link href="/web/resources/css/theme.css" rel="stylesheet" type="text/css" media="all" />
    <link href='http://fonts.googleapis.com/css?family=Lato:300,400%7CRaleway:100,400,300,500,600,700%7COpen+Sans:400,500,600' rel='stylesheet' type='text/css'>

        <script src="/web/resources/js/jquery.min.js"></script>
        <script src="/web/resources/js/bootstrap.min.js"></script>
        <script src="/web/resources/js/flexslider.min.js"></script>
        <script src="/web/resources/js/parallax.js"></script>
        <script src="/web/resources/js/scripts.js"></script>

		<script src="/web/resources/js/lightbox.min.js"></script>
        <script src="/web/resources/js/masonry.min.js"></script>
        <script src="/web/resources/js/ytplayer.min.js"></script>
        <script src="/web/resources/js/countdown.min.js"></script>
        <script src="/web/resources/js/smooth-scroll.min.js"></script>
</head>




<div class="nav-container">
    <nav>
        <div class="nav-bar">
            <div class="module left">
                <a href="index.html">
                    <img class="logo logo-light" alt="Foundry" src="/web/resources/img/logo-light.png">
                    <img class="logo logo-dark" alt="Foundry" src="/web/resources/img/logo-dark.png">
                </a>
            </div>
            <div class="module widget-handle mobile-toggle right visible-sm visible-xs">
                <i class="ti-menu"></i>
            </div>
            <div class="module-group right">

                <div class="module left">
                    <ul class="menu">
                        <li>
                            <a href="tracking.html">트레킹 리스트</a>
                        </li>

                        <li>
                            <a href="cart.html">메타 장바구니</a>
                        </li>

                        <li>
                            <a href="#">Q & A</a>
                        </li>

                    </ul>

                </div>

                <div class="module widget-handle left">
                    <ul class="menu">
                        <li>
                            <a href="login.html">로그인</a>
                        </li>

                        <!--
                                <li class="modal-container">
                                    <a class="btn-modal" href="#">로그인</a>
                                    <div class="foundry_modal">

                                        <div class="col-md-8 col-md-offset-2 col-sm-8 col-sm-offset-2">   
                                            <div class="feature bordered text-center">
                                                <h4 class="uppercase">Login Here</h4>
                                                <form class="text-left">
                                                    <input class="mb0" type="text" placeholder="Username" />
                                                    <input class="mb0" type="password" placeholder="Password" />
                                                    <input type="submit" value="Login" />
                                                </form>
                                                <p class="mb0">Forgot your password?<br>
                                                    <a href="#">Click Here To Reset</a>
                                                </p>
                                            </div>
                                        </div>

                                    </div>
                                </li>
-->


                    </ul>
                </div>
            </div>

        </div>
    </nav>
</div>










<body>

    <div class="main-container">

        <section class="cover fullscreen image-bg overlay">
            <div class="background-image-holder">
                <img alt="image" class="background-image" src="/web/resources/img/cover8.jpg">
            </div>


            <div class="container v-align-transform">
                <div class="row">
                    <div class="col-sm-12 text-center">
                        <img alt="Pic" src="/web/resources/img/logo-light.png" class="image-small">
                    </div>
                </div>

                <br><br><br>

                <div class="row">
                    <div class="col-md-6 col-md-offset-3 col-sm-10 col-sm-offset-1">
                        <div class="feature bordered text-center">
                            <h3 class="uppercase">start tracking</h3>
                            <br>
                            <form class="halves form-newsletter" data-success="Thanks for your submission, we will be in touch shortly." data-error="Please fill all fields correctly.">
                                <input class="mb16 validate-required validate-email signup-email-field" type="text" placeholder="URL을 입력하세요" name="email">
                                <button class="mb16" type="submit">Notify Me</button>

                            </form>
                            <br><br><br>
                            <p>
                                해당 상품이 원하는 가격에 도달하면 알려드립니다 !
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </section>









        <section>
            <div class="container">
                <div class="row">
                    <div class="col-md-2 col-sm-4">
                        <div class="select-option">
                            <i class="ti-angle-down"></i>
                            <select>
                                    <option selected value="Default">Sort By</option>
                                    <option value="Small">Highest Price</option>
                                    <option value="Medium">Lowest Price</option>
                                    <option value="Larger">Newest Items</option>
                                </select>
                        </div>
                        <!--end select-->
                    </div>
                    <div class="col-md-10 text-right">
                        <span class="input-lh">Displaying 8 of 8 results</span>
                    </div>
                </div>
                <!--end of row-->
                <div class="row">
                    <div class="col-sm-12">
                        <hr>
                    </div>
                </div>
                <!--end of row-->
                <div class="row masonry">
                    <div class="col-md-3 col-sm-4 masonry-item col-xs-12">
                        <div class="image-tile outer-title text-center">
                            <a href="#">
                                <img alt="Pic" class="product-thumb" src="/web/resources/img/shop-product-1.jpg" />
                            </a>
                            <div class="title">
                                <h5 class="mb0">Adrian
                                    <br /> LambsWool Cap</h5>
                                <span class="display-block mb16">$49.95</span>
                            </div>
                        </div>
                    </div>
                    <!--end three col-->
                    <div class="col-md-3 col-sm-4 masonry-item col-xs-12">
                        <div class="image-tile outer-title text-center">
                            <a href="#">
                                <img alt="Pic" class="product-thumb" src="/web/resources/img/shop-product-2.jpg" />
                            </a>
                            <div class="title">
                                <h5 class="mb0">Stanley
                                    <br /> Leather Wallet</h5>
                                <span class="display-block mb16">$69.95</span>
                            </div>
                        </div>
                    </div>
                    <!--end three col-->
                    <div class="col-md-3 col-sm-4 masonry-item col-xs-12">
                        <div class="image-tile outer-title text-center">
                            <a href="#">
                                <span class="label">Sale</span>
                                <img alt="Pic" class="product-thumb" src="/web/resources/img/shop-product-4.jpg" />
                            </a>
                            <div class="title">
                                <h5 class="mb0">Logan
                                    <br /> Canvas Backpack</h5>
                                <span class="display-block mb16">$119.95</span>
                            </div>
                        </div>
                    </div>
                    <!--end three col-->
                    <div class="col-md-3 col-sm-4 masonry-item col-xs-12">
                        <div class="image-tile outer-title text-center">
                            <a href="#">
                                <img alt="Pic" class="product-thumb" src="/web/resources/img/shop-product-7.jpg" />
                            </a>
                            <div class="title">
                                <h5 class="mb0">Vladimir
                                    <br />Stainless Flask</h5>
                                <span class="display-block mb16">$49.95</span>
                            </div>
                        </div>
                    </div>
                    <!--end three col-->
                    <div class="col-md-3 col-sm-4 masonry-item col-xs-12">
                        <div class="image-tile outer-title text-center">
                            <a href="#">
                                <img alt="Pic" class="product-thumb" src="/web/resources/img/shop-product-8.jpg" />
                            </a>
                            <div class="title">
                                <h5 class="mb0">Nathan
                                    <br /> Cashmere Beanie</h5>
                                <span class="display-block mb16">$45.00</span>
                            </div>
                        </div>
                    </div>
                    <!--end three col-->
                    <div class="col-md-3 col-sm-4 masonry-item col-xs-12">
                        <div class="image-tile outer-title text-center">
                            <a href="#">
                                <img alt="Pic" class="product-thumb" src="/web/resources/img/shop-product-5.jpg" />
                            </a>
                            <div class="title">
                                <h5 class="mb0">Nicholas
                                    <br /> Dune Shades</h5>
                                <span class="display-block mb16">$79.95</span>
                            </div>
                        </div>
                    </div>
                    <!--end three col-->
                    <div class="col-md-3 col-sm-4 masonry-item col-xs-12">
                        <div class="image-tile outer-title text-center">
                            <a href="#">
                                <span class="label">Hot</span>
                                <img alt="Pic" class="product-thumb" src="/web/resources/img/shop-product-9.jpg" />
                            </a>
                            <div class="title">
                                <h5 class="mb0">Bobby
                                    <br />Shaving Brush</h5>
                                <span class="display-block mb16">$27.95</span>
                            </div>
                        </div>
                    </div>
                    <!--end three col-->
                    <div class="col-md-3 col-sm-4 masonry-item col-xs-12">
                        <div class="image-tile outer-title text-center">
                            <a href="#">
                                <img alt="Pic" class="product-thumb" src="/web/resources/img/shop-product-13.jpg" />
                            </a>
                            <div class="title">
                                <h5 class="mb0">Bradley
                                    <br /> Leather Journal</h5>
                                <span class="display-block mb16">$29.95</span>
                            </div>
                        </div>
                    </div>
                    <!--end three col-->
                    <div class="col-md-3 col-sm-4 masonry-item col-xs-12">
                        <div class="image-tile outer-title text-center">
                            <a href="#">
                                <img alt="Pic" class="product-thumb" src="/web/resources/img/shop-product-11.jpg" />
                            </a>
                            <div class="title">
                                <h5 class="mb0">Mack
                                    <br /> Steel Canteen</h5>
                                <span class="display-block mb16">$34.95</span>
                            </div>
                        </div>
                    </div>
                    <!--end three col-->
                </div>
                <!--end of row-->
            </div>
            <!--end of container-->
        </section>

    </div>

</body>

<footer class="footer-2 bg-dark text-center-xs">
    <div class="container">
        <div class="row">
            <div class="col-sm-4">
                <a href="#"><img class="image-xxs fade-half" alt="Pic" src="/web/resources/img/logo-light.png"></a>
            </div>

            <div class="col-sm-4 text-center">
                <span class="fade-half">
                                © Copyright 2015 Medium Rare - All Rights Reserved
                            </span>
            </div>

            <div class="col-sm-4 text-right text-center-xs">
                <ul class="list-inline social-list">
                    <li><a href="#"><i class="ti-twitter-alt"></i></a></li>
                    <li><a href="#"><i class="ti-facebook"></i></a></li>
                    <li><a href="#"><i class="ti-dribbble"></i></a></li>
                    <li><a href="#"><i class="ti-vimeo-alt"></i></a></li>
                </ul>
            </div>
        </div>
    </div>
</footer>


    
</html>
				