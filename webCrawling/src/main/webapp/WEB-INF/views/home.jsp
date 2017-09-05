<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="include/header.jsp"%>

<html lang="ko">

<body>

    <div class="main-container">

        <section class="cover fullscreen image-bg overlay">
            <div class="background-image-holder">
                <img alt="image" class="background-image" src="/resources/img/cover8.jpg">
            </div>

            <div class="container v-align-transform">
                <div class="row">
                    <div class="col-sm-12 text-center">
                        <img alt="Pic" src="/resources/img/logo-light.png" class="image-small">
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
                                <img alt="Pic" class="product-thumb" src="/resources/img/shop-product-1.jpg" />
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
                                <img alt="Pic" class="product-thumb" src="/resources/img/shop-product-2.jpg" />
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
                                <img alt="Pic" class="product-thumb" src="/resources/img/shop-product-4.jpg" />
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
                                <img alt="Pic" class="product-thumb" src="/resources/img/shop-product-7.jpg" />
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
                                <img alt="Pic" class="product-thumb" src="/resources/img/shop-product-8.jpg" />
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
                                <img alt="Pic" class="product-thumb" src="/resources/img/shop-product-5.jpg" />
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
                                <img alt="Pic" class="product-thumb" src="/resources/img/shop-product-9.jpg" />
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
                                <img alt="Pic" class="product-thumb" src="/resources/img/shop-product-13.jpg" />
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
                                <img alt="Pic" class="product-thumb" src="/resources/img/shop-product-11.jpg" />
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



</html>



<%@include file="include/footer.jsp"%>


    
				