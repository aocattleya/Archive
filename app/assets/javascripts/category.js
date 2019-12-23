$(document).on("turbolinks:load",function() {

  function appendOption(select){
  let html = `<option value="${select.id}">${select.name}</option>`
  return html;
  }

  function childBox(insertHTML){
  let childBoxHTML =`<div class="sell__main__content__form__box__group__select" id="child_box">
                      <i class="icon-arrow-bottom"></i>
                      <select class="sell__main__content__form__box__group__select__form" id="child_form" name="item[child_id]">
                        <option value="">---</option>
                        ${insertHTML}
                    </select>
                    </div>`
  $("#parent_box").after(childBoxHTML);
  }

  function grandChildBox(insertHTML){
  let grandChildBoxHTML =`<div class="sell__main__content__form__box__group__select" id="grandchild_box">
                            <i class="icon-arrow-bottom"></i>
                            <select class="sell__main__content__form__box__group__select__form" id="grandchild_form" name="item[category_id]">
                              <option value="">---</option>
                              ${insertHTML}
                            </select>
                          </div>`
  $("#child_box").after(grandChildBoxHTML);
  }

  clothesArray       = ["160","161","162","163","164","165","166","167","168","169","170","171","172","173","174","175","176","177","178","179","180",
                        "181","182","183","184","185","186","187","188","189","190","191","192","193","194","195","196","197","198","199","200","201",
                        "202","203","204","205","206","207","208","209","210","211","212","213","214","215","216","217","218","219","230","231","232",
                        "317","318","319","340","341","342","343","344","345","346","347","348","349","350","351","352","353","354","355","356","357",
                        "358","359","360","361","362","363","364","365","366","367","368","369","370","371","372","373","374","375","376","377","378",
                        "379","380","381","382","383","404","405","406","407","408","459","460","467","468","469","1087","1088","1098","1099"]

  ladiesShoesArray   = ["220","221","222","223","224","225","226","227","228","229","1085","1095"]

  mensShoesArray     = ["384","385","386","387","388","389","390","391","1084","1094"]

  babiesClothesArray = ["471","472","473","474","475","476","477","478","479","480","481","482","483","484",
                        "485","486","487","488","489","490","491","492","493","494","495","496","497"]

  kidsClothesArray   = ["498","499","500","501","502","503","504","505","506","507","508","509","510","511","512","513","514","515","516","517",
                        "518","519","520","521","522","523","524","525","526","527","528","529","530","531","532","533","534","1089","1100"]

  kidsShoesArray     = ["535","536","537","538","539","1086","1096"]

  lensArray          = ["978","979"]

  tvsArray           = ["983"]

  snowboardsArray    = ["1082"]

  skiingboardsArray  = ["1093"]

  tiresArray         = ["1222","1223","1224","1225"]

  motorcyclesArray   = ["1252"]

  helmetsArray       = ["1269"]

  $(function() {
    $("#parent_form").on('change', function(){
      let parentValue = $(this).val();
      if(parentValue != ""){
        $.ajax({
          url: "/categories/get_child_category",
          type: "GET",
          data: {
            parent_id: parentValue
          },
          dataType: "json"
        })
        .done(function(childs){
          $("#child_box").remove();
          $("#grandchild_box").remove();
          $("#size-select-box").hide();
          let insertHTML = "";
          childs.forEach(function(child){
            insertHTML += appendOption(child);
          });
          childBox(insertHTML);
          $('#parent_form').css('margin','0');
        })
        .fail(function(){
          alert("カテゴリー取得に失敗しました");
        })
      } else {
        $("#child_box").remove();
        $("#grandchild_box").remove();
        $("#size-select-box").hide();
      }
    })
  })

  $(function() {
    $("#category-select-box_list").on('change', "#child_form", function(){
      let childValue = $("#child_form").val();
      if(childValue != ""){
        $.ajax({
          url: "/categories/get_grandchild_category",
          type: "GET",
          data: {
            child_id: childValue
          },
          dataType: "json"
        })
        .done(function(grandchilds){
          $("#grandchild_box").remove();
          $("#size-select-box").hide()
          let insertHTML = "";
          grandchilds.forEach(function(grandchild){
            insertHTML += appendOption(grandchild);
          });
          grandChildBox(insertHTML);
          $('#child_form').css('margin','0');
        })
        .fail(function(){
          alert("カテゴリー取得に失敗しました");
        })
      } else {
        $("#grandchild_box").remove();
        $("#size-select-box").hide()
      }
    })
  })

  $(function() {
    $("#category-select-box_list").on('change', "#grandchild_form", function(){
      let grandChildValue = $("#grandchild_form").val();
      if(grandChildValue != ""){
        if(clothesArray.indexOf(grandChildValue) >= 0) {
          $("#size-select-box").show();
          $("#clothes-size").siblings().hide();
          $("#clothes-size").show()
        }else if(ladiesShoesArray.indexOf(grandChildValue) >= 0) {
          $("#size-select-box").show();
          $("#ladies-shoes-size").siblings().hide();
          $("#ladies-shoes-size").show();
        }else if(mensShoesArray.indexOf(grandChildValue) >= 0) {
          $("#size-select-box").show();
          $("#mens-shoes-size").siblings().hide();
          $("#mens-shoes-size").show();
        }else if(babiesClothesArray.indexOf(grandChildValue) >= 0) {
          $("#size-select-box").show();
          $("#babies-clothes-size").siblings().hide();
          $("#babies-clothes-size").show();
        }else if(kidsClothesArray.indexOf(grandChildValue) >= 0) {
          $("#size-select-box").show();
          $("#kids-clothes-size").siblings().hide();
          $("#kids-clothes-size").show();
        }else if(kidsShoesArray.indexOf(grandChildValue) >= 0) {
          $("#size-select-box").show();
          $("#kids-shoes-size").siblings().hide();
          $("#kids-shoes-size").show();
        }else if(lensArray.indexOf(grandChildValue) >= 0) {
          $("#size-select-box").show();
          $("#lens-size").siblings().hide();
          $("#lens-size").show();
        }else if(tvsArray.indexOf(grandChildValue) >= 0) {
          $("#size-select-box").show();
          $("#tvs-size").siblings().hide();
          $("#tvs-size").show();
        }else if(snowboardsArray.indexOf(grandChildValue) >= 0) {
          $("#size-select-box").show();
          $("#snowboards-size").siblings().hide();
          $("#snowboards-size").show();
        }else if(skiingboardsArray.indexOf(grandChildValue) >= 0) {
          $("#size-select-box").show();
          $("#skiingboards-size").siblings().hide();
          $("#skiingboards-size").show();
        }else if(tiresArray.indexOf(grandChildValue) >= 0) {
          $("#size-select-box").show();
          $("#tires-size").siblings().hide();
          $("#tires-size").show();
        }else if(motorcyclesArray.indexOf(grandChildValue) >= 0) {
          $("#size-select-box").show();
          $("#motorcycles-size").siblings().hide();
          $("#motorcycles-size").show();
        }else if(helmetsArray.indexOf(grandChildValue) >= 0) {
          $("#size-select-box").show();
          $("#helmets-size").siblings().hide();
          $("#helmets-size").show();
        }else {
          $("#size-select-box").hide();
        }
      } else {
        $("#size-select-box").hide();
      }
    })
  })

  $(function() {
    $("#size-select-box").find("select").on('change', function(){
      $("#size-select-box").find("select").attr("name", "item[hoge]")
      $(this).attr("name","item[size]")
    })
  })

  $(function() {
    $("#category-select-box_list").on('change', "#grandchild_form", function(){
      let grandChildValue = $("#grandchild_form").val();
      if(grandChildValue != ""){
        if(clothesArray.indexOf(grandChildValue) >= 0) {
          $("#brandbox_list").show();
          $("#input_brand_box").siblings().hide();
          $("#input_brand_box").show()
        }else {
          $("#brandbox_list").hide();
        }
      } else {
        $("#brandbox_list").hide();
      }
    })
  })

});

$(document).on("turbolinks:load",function() {
  $(function(){
    $("#item_price").on('input',function(){
      let price = $(this).val();
      let minPrice = 300
      let maxPrice = 9999999
      let fee = 10
      let tax = Math.floor(price / fee)
      let taxProfit = tax.toLocaleString()
      let profit = price - tax
      let kanmaProfit = profit.toLocaleString()
      if(price >= minPrice && price <= maxPrice){
        $("#tax-text").text("¥" + taxProfit);
        $("#profit-text").text("¥" + kanmaProfit);
      } else {
        $("#tax-text").text("-");
        $("#profit-text").text("-");
      }
    })
  })
});

$(document).on("turbolinks:load",function() {
  var addResult = $("#search_brand_result");

  function brandHit(brand) {
    var html = `<li id="${brand.id}" class="brand_box_list">${brand.name}</li>`
    addResult.append(html);
  }

  $(function(){
    $("#input_brand_box").on("keyup", function() {
      var input = $("#input_brand_box").val();
      $.ajax({
        type: 'GET',
        url: '/brands/search_brand',
        data: { keyword: input },
        dataType: 'json'
      })
      .done(function(brands) {
          $("#search_brand_result").children().remove();
        if(input == ""){
          $("#search_brand_result").children().remove();
          return
        }
        if (brands.length !== 0) {
          brands.forEach(function(brand) {
            brandHit(brand);
          });
        }
      })
      .fail(function() {
        alert("通信エラーです。ユーザーが表示できません。");
      });
    });
  })
});

$(document).on("turbolinks:load",function() {
  $(function(){
    $(document).on('mouseover',"#search_brand_result > li", function(){
      $(this).css({"color":"#fff","background":"#0099e8"})
    })
    $(document).on('mouseout',"#search_brand_result > li", function(){
      $(this).css({"color":"#333","background":"#fff"})
    })
    $(document).on('click',"#search_brand_result li", function(){
      let brandText = $(this).text();
      let brandId = $(this).attr("id");
      $("#input_brand_box").val(brandText);
      $("#item_brand_id").val(brandId);
      $("#search_brand_result > li").remove()
    })
  })
});
