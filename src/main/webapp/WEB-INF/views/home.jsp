<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>LBYCLDS Hands On Exam</title>

    <!-- Bootstrap Core CSS -->
    <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Lora:400,700,400italic,700italic" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">

    <!-- Theme CSS -->
    <link href="css/grayscale.min.css" rel="stylesheet">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>

<body id="page-top" data-spy="scroll" data-target=".navbar-fixed-top">

    <!-- Navigation -->
    <nav class="navbar navbar-custom navbar-fixed-top" role="navigation">
        <div class="container">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-main-collapse">
                    Menu <i class="fa fa-bars"></i>
                </button>
                <a class="navbar-brand page-scroll" href="#page-top">
                    <i class="fa fa-play-circle"></i> <span>S2T2T
                </a>
            </div>
            <!-- /.navbar-collapse -->
        </div>
        <!-- /.container -->
    </nav>

    <!-- Intro Header -->
    <header class="intro">
        <div class="intro-body">
            <div class="container">
                <div class="row">
                    <div class="col-md-8 col-md-offset-2">
                        <h1 class="brand-heading">S2T2T</h1>
                        <p class="intro-text">Converts Speech into Text and translates it.
                            <br>Start by clicking the button below.</p>
                        <a href="#step1" class="btn btn-circle page-scroll">
                            <i class="fa fa-angle-double-down animated"></i>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </header>

    <!-- About Section -->
    <section id="step1" class="container content-section text-center">
        <div class="row">
            <div class="col-lg-8 col-lg-offset-2">
                <h2>Choose a File...</h2>
                <div class="form-group">
                    <form method="POST" action="home?mode=speechtotext" enctype="multipart/form-data">
                        <input type="file" name="file" accept=".wav">
                        <input type="submit" name="submit" class="btn btn-default btn-lg" value="Convert">
                    </form>               
                </div>
                <br>
                
                <c:if test="${!empty transcription}">
	                <h3>Transcript: </h3>
	                <p>${transcription}</p>
	
	                <hr>
	                <a href="#step2" class="btn btn-default btn-lg page-scroll">Proceed to Step 2</a>
                </c:if>

            </div>
        </div>
    </section>

    <!-- Download Section -->
    <section id="step2" class="content-section text-center">
        <div class="download-section">
            <div class="container">
                <div class="col-lg-8 col-lg-offset-2">
                    <h2>Choose a language...</h2>
                    <div class="form-group">
                        <form method="POST" action="home?mode=translate">
                            <input type="hidden" name="tr-from" value="${transcription}">
                            
                            <p class="tr-selector">
                                <select name="tr-model-id" class="form-control">
                                    <option value="en-ar">English - Arabic</option>
                                    <option value="en-fr">English - French</option>
                                    <option value="en-pt">English - Portuguese</option>
                                    <option value="en-es">English - Spanish</option>
                                </select>
                                <br>
                                <button class="btn btn-default btn-lg" type="submit">Translate</button>
                            </p>        
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Contact Section -->
    <c:if test="${!empty translation}">
        <section id="step3" class="container content-section text-center">
            <div class="row">
                <div class="col-lg-8 col-lg-offset-2">
                    <h2>Translated Text:</h2>
                    <p>${translation}</p>
                    <a href="#step1" class="btn btn-default btn-lg  page-scroll">Convert again</a>
                </div>
            </div>
        </section>
    </c:if>

    <!-- Footer -->
    <footer>
        <div class="container text-center">
            <p>Copyright &copy; s2t2t.bluemix.net 2017</p>
        </div>
    </footer>

    <!-- jQuery -->
    <script src="vendor/jquery/jquery.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="vendor/bootstrap/js/bootstrap.min.js"></script>

    <!-- Plugin JavaScript -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.3/jquery.easing.min.js"></script>

    <!-- Google Maps API Key - Use your own API key to enable the map feature. More information on the Google Maps API can be found at https://developers.google.com/maps/ -->
    <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCRngKslUGJTlibkQ3FkfTxj3Xss1UlZDA&sensor=false"></script>

    <!-- Theme JavaScript -->
    <script src="js/grayscale.min.js"></script>

</body>

</html>
