// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require popper
//= require turbolinks
//= require bootstrap
//= require underscore
//= require gmaps/google
//= require_tree .

$(document).ready(function(){

  // To check valid values or not.
  var namecheck = /^[a-zA-Z ]+$/;
  var emailcheck = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
  var passwordcheck = /^((?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%]).{6,20})+/;

  // To check whether correct values are entered or not.
  var nameFlag = 0;
  var emailFlag = 0;
  var passwordFlag = 0;
  var passwordConfirmFlag = 0;
  var imageFlag = 0;

  $(".login").submit(function(){
    // Get the values from forms.
    var email = $("#user_email").val();
    var password = $("#user_password").val();

    if (email == "") {
      $('#email-error').text("* Fill your email.");
      $("#email-error").show();
      emailFlag = 1;
    } else if ( !emailcheck.test(email) ){
      $('#email-error').text("* Enter valid email address.");
      $('#email-error').show();
      emailFlag = 1;
    }

    if (password == "") {
      $('#password-error').text("* Please enter your password.");
      $('#password-error').show();
      passwordFlag = 1;
    } else if ( !passwordcheck.test(password) ) {
      $('#password-error').text("Password should be 1 digit, 1 lowercase, 1 uppercase and 1 special symbol(@#$%).");
      $('#password-error').show();
      passwordFlag = 1;
    }

    if (emailFlag == 1 || passwordFlag == 1) {
      emailFlag = 0;
      passwordFlag = 0;
      return false;
    }
    else {
      emailFlag = 0;
      passwordFlag = 0;
      return true;
    }
  });

  $(".signup").submit(function(){
    // Get the values from forms.
    var name = $("#user_name").val();
    var email = $('#user_email').val();
    var password = $('#user_password').val();
    var password_confirmation = $('#user_password_confirmation').val();
    var image = $('#user_image_name').val();

    if (name == "") {
      $('#name-error').text("* Please enter your name.");
      $('#name-error').show();
      nameFlag = 1;
    } else if ( !namecheck.test(name) ){
      $('#name-error').text("* Name should be alphabhet.");
      $('#name-error').show();
      nameFlag = 1;
    } else {
      $('#name-error').hide();
      nameFlag = 0;
    }

    if (email == "") {
      $('#email-error').text("* Fill your email.");
      $('#email-error').show();
      emailFlag = 1;
    } else if ( !emailcheck.test(email) ){
      $('#email-error').text("* Enter valid email address.");
      $('#email-error').show();
      emailFlag = 1;
    } else {
      $('#email-error').hide();
      emailFlag = 0;
    }

    if (password == "") {
      $('#password-error').text("* Please enter the password.");
      $('#password-error').show();
      passwordFlag = 1;
    } else if ( !passwordcheck.test(password) ){
      $('#password-error').text("* Password should be 1 digit, 1 lowercase, 1 uppercase and 1 special symbol");
      $('#password-error').show();
      passwordFlag = 1;
    } else {
      $('#password-error').hide();
      passwordFlag = 0;
    }

    if (password_confirmation == "") {
      $('#password-confirmation-error').text("* Please enter your password again.");
      $('#password-confirmation-error').show();
      passwordConfirmFlag = 1;
    } else if (password_confirmation != password) {
      $('#password-confirmation-error').text("* Please enter the same password.");
      $('#password-confirmation-error').show();
      passwordConfirmFlag = 1;
    } else {
      $('#password-confirmation-error').hide();
      passwordFlag = 0;
    }

    if (image == "") {
      $('#image-error').text("* Please select your image.");
      $('#image-error').show();
      imageFlag = 1;
    } else {
      $('#image-error').hide();
      imageFlag = 0;
    }

    if(nameFlag == 1 || emailFlag == 1 || passwordFlag == 1 || passwordConfirmFlag == 1 || imageFlag == 1){
      nameFlag = 0;
      emailFlag = 0;
      passwordFlag = 0;
      passwordConfirmFlag = 0;
      imageFlag = 0;
      return false;
    } else {
      nameFlag = 0;
      emailFlag = 0;
      passwordFlag = 0;
      passwordConfirmFlag = 0;
      imageFlag = 0;
      return true;
    }
  });

  $(".change-password").submit(function(){
    var password = $("#user_password").val();
    var password_confirmation = $("#user_password_confirmation").val();

    if (password == "") {
      $('#password-error').text("* Please enter the password.");
      $('#password-error').show();
      passwordFlag = 1;
    } else if ( !passwordcheck.test(password) ){
      $('#password-error').text("* Password should be 1 digit, 1 lowercase, 1 uppercase and 1 special symbol");
      $('#password-error').show();
      passwordFlag = 1;
    } else {
      $('#password-error').hide();
      passwordFlag = 0;
    }

    if (password_confirmation == "") {
      $('#password-confirmation-error').text("* Please enter your password again.");
      $('#password-confirmation-error').show();
      passwordConfirmFlag = 1;
    } else if (password_confirmation != password) {
      $('#password-confirmation-error').text("* Please enter the same password.");
      $('#password-confirmation-error').show();
      passwordConfirmFlag = 1;
    } else {
      $('#password-confirmation-error').hide();
      passwordFlag = 0;
    }

    if (passwordFlag == 1 || passwordConfirmFlag == 1) {
      passwordFlag = 0;
      passwordConfirmFlag = 0;
      return false;
    } else {
      passwordFlag = 0;
      passwordConfirmFlag = 0;
      return true;
    }

  });

  $(".post").submit(function(){
    var post = $("#post_content").val();
    var image = $("#post_image_name").val();

    if (post == "" && image == "") {
      $('#post-error').text("* Please enter your posts or choose upload data.");
      $('#post-error').show();
      return false;
    } else {
      $('#post-error').hide();
      return true;
    }
  });


  // For post location
  $('#location').click(function(){
    // Whether user's browser can use GeoLacation API or not
    if ( navigator.geolocation ) {
      // Get location info
      navigator.geolocation.getCurrentPosition(

        // [Argument No.1] When getting the location info successfully, it'll be used.
        function(position) {
          // Coordinate get data(this is saved as an array)
          var data = position.coords;

          // Arrange the data
          var lat = parseFloat(data.latitude);
          var lng = parseFloat(data.longitude);
          var alt = parseFloat(data.altitude);
          var accLatlng = parseFloat(data.accuracy);
          var accAlt = parseFloat(data.altitudeAccuracy);
          var heading = parseFloat(data.heading);   // 0=north,90=east,180=south,270=west
          var speed = parseFloat(data.speed);

          var address = 0;

          // Display alert
          // alert( "Your location is \n[" + lat + "," + lng + "]\n" ) ;

          // Display as a HTML
          // document.getElementById('result').innerHTML = '<dl><dt>latitude</dt><dd>' + lat +
          //                                               '</dd><dt>longitude</dt><dd>' + lng +
          //                                               '</dd><dt>altitude</dt><dd>' + alt +
          //                                               '</dd><dt>accuracy of lat and lng</dt><dd>' + accLatlng +
          //                                               '</dd><dt>accuracy of altitude</dt><dd>' + accAlt +
          //                                               '</dd><dt>heading</dt><dd>' + heading +
          //                                               '</dd><dt>speed</dt><dd>' + speed + '</dd></dl>';

          let promise = new Promise((resolve, reject) => { // #1
            console.log('#1')
            // alert("before geocoder func: "+address);
            geocoder(lat, lng);
            resolve(address)
          })

          promise.then((address) => { // #2
            return new Promise((resolve, reject) => {
              setTimeout(() => {
                console.log('#2')
                initMap(lat, lng, address);
                resolve(address)
              }, 500)
            })
          }).catch(() => { // error hundle
            console.error('Something wrong!')
          })

          // alert("before geocoder func: "+address);
          // geocoder(lat, lng);
          // alert("before initMap func: "+address);
          // initMap(lat, lng, address);
        },

        // [Argument No.2] When getting location info failed, it'll be used.
        function(error) {
          // Error code number(error.code)
          // 0:UNKNOWN_ERROR
          // 1:PERMISSION_DENIED      Users didn't allow using their location info.
          // 2:POSITION_UNAVAILABLE   Couldn't get location info(ex: signal situation).
          // 3:TIMEOUT                It took too much time to get locaction info.

          // Error messages
          var errorInfo = [
            "UNKNOWN_ERROR" ,
            "PERMISSION_DENIED" ,
            "POSITION_UNAVAILABLE" ,
            "TIMEOUT"
          ];

          var errorNo = error.code;
          var errorMessage = "[Error No." + errorNo + "]\n" + errorInfo[ errorNo ];

          // Display alert
          alert(errorMessage);

          // Display as HTML
          document.getElementById( 'result' ).innerHTML = errorMessage;
        } ,

        // [Argument No.3] Option
        {
          "enableHighAccuracy": false,
          "timeout": 8000,
          "maximumAge": 2000,
        }

      ) ;
    } else {
      var errorMessage = "Your browser doesn't support GeoLacation API.";
      alert( errorMessage );
      document.getElementById( 'result' ).innerHTML = errorMessage;
    }
  });


  $('.posted').click(function(){
    var postedAddress = "";
    var geocoder = new google.maps.Geocoder();
    // alert(id);
    // alert(postedLatitude);
    // alert(postedLongitude);

    // Display google map
    var map = new google.maps.Map(document.getElementById('posted-map') , {
      // Center Coordinate [latlng]
      center: {
        lat: postedLatitude,
        lng: postedLongitude
      },
      zoom: 15   // Zoom value
    });

    // Display transit information
    var transitLayer = new google.maps.TransitLayer();
    transitLayer.setMap(map);

    // Display a marker that indicates user's location
    var marker = new google.maps.Marker({
      position: {
        lat: postedLatitude,
        lng: postedLongitude
      },
      map: map,
      title: contentString
    });

    var contentString = 'Address：' + postedAddress;
    var infowindow = new google.maps.InfoWindow({
      content: contentString
    });

    $('.posted-map').show();

  });

  // $('.like').click(function(){
  //   var current = $(this);
  //   var id = $(current).attr("id");
  //   var uid = $('#u-id').text();
  //   var count = $(current).find("#count").text();
  //   count = parseInt(count);
  //   alert(id);
  //   $.ajax({
  //     url: "/likes",
  //     type: "POST",
  //     dataType: "JSON",
  //     data: { like: { user_id: uid, post_id: id } },
  //     error:function(error){
  //       console.log(error);
  //     },
  //     success:function(data){
  //       if (data.status === "success") {
  //         alert("ok");
  //         count = count +1;
  //         alert(count);
  //         $(current).find('#count').text(count);
  //         $('.unlike').show();
  //         $('.like').hide();
  //       }
  //       console.log(data);
  //
  //     }
  //   });
  // });
  //
  // $('.unlike').click(function(){
  //   var current = $(this);
  //   var id = $(current).attr("id");
  //   var uid = $('#u-id').text();
  //   // var uid = $('#u-id').text();
  //   var count = $(current).find("#count").text();
  //   count = parseInt(count);
  //   alert(id);
  //   $.ajax({
  //     url: "/likes/destroy",
  //     type: "delete",
  //     dataType: "JSON",
  //     data: { like: { user_id: uid,  post_id: id } },
  //     error:function(error){
  //       console.log(error);
  //     },
  //     success:function(data){
  //       if (data.status === "success") {
  //         alert("ok");
  //         count = count - 1;
  //         alert(count);
  //         $(current).find('#count').text(count);
  //       }
  //       console.log(data);
  //       $('.like').hide();
  //       $('.unlike').show();
  //     }
  //   });
  // });

  function geocoder(lat, lng) {
    var geocoder = new google.maps.Geocoder();
    geocoder.geocode({
      latLng: {
        lat: lat,
        lng: lng
      }
    }, function(results, status) {
      if (status == google.maps.GeocoderStatus.OK) {
        if (results[0].geometry) {
          address = results[0].formatted_address;
          $('#post_latitude').val(lat);
          $('#post_longitude').val(lng);
          $('#post_address').val(address);
          $('.address').html('Address: ' + address);
          $('.address').show();

          // alert("in geocoder func"+address);
        }
      }
    });
  }

  function initMap(lat, lng, address) {
    // Display google map
    var map = new google.maps.Map(document.getElementById('map-canvas') , {
      // Center Coordinate [latlng]
      center: {
        lat: lat,
        lng: lng
      },
      zoom: 15   // Zoom value
    });

    // Display transit information
    var transitLayer = new google.maps.TransitLayer();
    transitLayer.setMap(map);

    var contentString = 'Address：' + address;
    var infowindow = new google.maps.InfoWindow({
      content: contentString
    });

    // Display a marker that indicates user's location
    var marker = new google.maps.Marker({
      position: {
        lat: lat,
        lng: lng
      },
      map: map,
      title: contentString
    });

    // var infowindow = new google.maps.InfoWindow();
    // google.maps.event.addListener(marker, 'click', (function(marker) {
    //   return function() {
    //     infowindow.setContent(contentString);
    //     infowindow.open(map, marker);
    //   }
    // })(marker));

    // var infowindow = new google.maps.InfoWindow();
    // infowindow.setContent(contentString);
    // infowidow.open(map, marker);

    marker.addListener('mouseup', function() {
      infowindow.open(map, marker);
    });

    $('#map-canvas').show();

    // $(window).resize(function(){
    //   google.maps.event.trigger(map, "resize");
    // });
  }

// To display user's posts and liked posts in user edit page using ajax(Under construction)
  // $('.your-posts').click(function(){
  //   // ajax fundtion needs one argument to pass the controller and to get data from database
  //   ajaxYourPosts($(this).attr('id'));
  // });
  //
  // $('.liked-posts').click(function(){
  //   // ajax function needs one argument, so write "" and pass to avoid unexpected error
  //   ajaxLikedPosts($(this).attr('id'));
  // });
  //
  // function ajaxYourPosts(id) {
  //   $.ajax({
  //     url: "/",
  //     type: "GET",
  //     dataType: "JSON",
  //     // if you want to pass the data to controller, write params[:id] in the controller
  //     data: { id: id },
  //
  //     error:function(error){
  //       console.log(error);
  //     },
  //
  //     success:function(data){
  //       // for initialize
  //       // $('.users-posts').html("").fadeOut();
  //       console.log(data);
  //       $.each(data,function(key, value){
  //         console.log(value.img_name.url);
  //         var pro = ""
  //
  //         $('.users-posts').append(pro).fadeIn();
  //       });
  //     }
  //   });
  // }

});
