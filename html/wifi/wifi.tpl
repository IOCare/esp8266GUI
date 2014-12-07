<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <meta name="description" content="Responsive UI for ESP8266">
    <meta name="author" content="Rajendra Khope">
    <link rel="icon" href="../favicon.ico">

    <title>WiFi connection</title>

    <!-- Bootstrap core CSS -->
    <link href="../css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <style type="text/css">
	body {
	  padding-top: 70px;
	}
	.footer {
	  background-color: #00cccc;
	}
	.icon {
		background-image: url("icons.png");
		background-color: transparent;
		width: 32px;
		height: 32px;
		display: inline-block;
	}
    </style>

  </head>

  <body>

    <!-- Fixed navbar -->
    <nav class="navbar navbar-default navbar-fixed-top" role="navigation">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="/"><img src="../32.png" width="32" height="32" alt="" /> </a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
          <ul class="nav navbar-nav">
            <li ><a href="/">Home</a></li>
            <li><a href="#about" data-toggle="modal" data-target="#myModal">About</a></li>
            <li><a href="#contact" data-toggle="modal" data-target="#contactModal">Contact</a></li>
          </ul>
          <ul class="nav navbar-nav navbar-right">
            <li class="active"><a href="wifi">WLAN Config</a></li>
          </ul>
        </div><!--/.nav-collapse -->
      </div>
    </nav>

    <div class="container">

	<!-- Modal -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
		<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
		<h4 class="modal-title" id="myModalLabel">About</h4>
	      </div>
	      <div class="modal-body">
		ESP8266 Responsive UI with bootstrap
	      </div>
	      <div class="modal-footer">
		<button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
	      </div>
	    </div>
	  </div>
	</div>

	<!-- Modal -->
	<div class="modal fade" id="contactModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
		<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
		<h4 class="modal-title" id="myModalLabel">Contact</h4>
	      </div>
	      <div class="modal-body">
		UI Designed by: Rajendra Khope<br />
		Email: research@iocare.in<br />
		Website: www.iocare.in
	      </div>
	      <div class="modal-footer">
		<button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
	      </div>
	    </div>
	  </div>
	</div>

      <!-- Main component for a content -->
      <div class="jumbotron">
        <h1>WiFi connection</h1>


	<div id="main">
		<p>
			Current WiFi mode: <span class="badge"><b>%WiFiMode%</b>
		</p>
		<p>
			<div id="" class="alert alert-info">
				Note: <b>%WiFiapwarn%</b>
			</div>
		</p>
		<form name="wifiform" action="connect.cgi" method="post">
		<p>
			To connect to a WiFi network, please select one of the detected networks...<br>

		<div id="aps" class="alert alert-success">Scanning...</div>
		<br>
		WiFi password, if applicable: <br />
		<label for="passwd"><input type="text" id="label" name="passwd" val="%WiFiPasswd%" class="form-control"></label> 
		<input type="submit" name="connect" value="Connect!" class="btn btn-lg btn-success">
		</p>
	</div>



      </div>

    </div> <!-- /container -->

<nav class="navbar navbar-default navbar-fixed-bottom" role="navigation">
  <div class="container">
     <ul class="nav navbar-nav navbar-left">
	<li><a>ESP8266 Responsive UI with bootstrap</a></li>
      </ul>
  </div>
</nav>

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="../js/jquery.min.js"></script>
    <script src="../js/bootstrap.min.js"></script>
	<script type="text/javascript">
	<!--
		$(document).ready(function () {

		});
	//-->
	</script>

<script type="text/javascript" src="140medley.min.js"></script>
	<script type="text/javascript">

	var xhr=j();
	var currAp="%currSsid%";

	function createInputForAp(ap) {
		if (ap.essid=="" && ap.rssi==0) return;
		var div=document.createElement("div");
		div.id="apdiv";
		var rssi=document.createElement("div");
		var rssiVal=-Math.floor(ap.rssi/5)*32;
		rssi.className="icon";
		rssi.style.backgroundPosition="0px "+rssiVal+"px";
		var encrypt=document.createElement("div");
		var encVal="-64"; //assume wpa/wpa2
		if (ap.enc=="0") encVal="0"; //open
		if (ap.enc=="1") encVal="-32"; //wep
		encrypt.className="icon";
		encrypt.style.backgroundPosition="-32px "+encVal+"px";
		var input=document.createElement("input");
		input.type="radio";
		input.name="essid";
		input.value=ap.essid;
		if (currAp==ap.essid) input.checked="1";
		input.id="opt-"+ap.essid;
		var label=document.createElement("label");
		label.htmlFor="opt-"+ap.essid;
		label.textContent=ap.essid;
		div.appendChild(input);
		div.appendChild(rssi);
		div.appendChild(encrypt);
		div.appendChild(label);
		return div;
	}

	function getSelectedEssid() {
		var e=document.forms.wifiform.elements;
		for (var i=0; i<e.length; i++) {
			if (e[i].type=="radio" && e[i].checked) return e[i].value;
		}
		return currAp;
	}


	function scanAPs() {
		xhr.open("GET", "wifiscan.cgi");
		xhr.onreadystatechange=function() {
			if (xhr.readyState==4 && xhr.status>=200 && xhr.status<300) {
				var data=JSON.parse(xhr.responseText);
				currAp=getSelectedEssid();
				if (data.result.inProgress=="0" && data.result.APs.length>1) {
					$("#aps").innerHTML="";
					for (var i=0; i<data.result.APs.length; i++) {
						if (data.result.APs[i].essid=="" && data.result.APs[i].rssi==0) continue;
						$("#aps").appendChild(createInputForAp(data.result.APs[i]));
					}
					window.setTimeout(scanAPs, 20000);
				} else {
					window.setTimeout(scanAPs, 1000);
				}
			}
		}
		xhr.send();
	}


	window.onload=function(e) {
		scanAPs();
	};
</script>

  </body>
</html>
