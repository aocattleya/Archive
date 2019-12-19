$(document).on('turbolinks:load', function(){
  $('.slick').slick({
    prevArrow: '<i class="fas fa-chevron-left "></i>',
    nextArrow: '<i class="fas fa-chevron-right "></i>',
    autoplay:true,
    autoplay:4000,
    dots:true,
    arrows:true,
  });
});