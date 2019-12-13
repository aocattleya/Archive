$(() => {
  let images = [];
  const previewHTML = img => {
    const html =
      `<div class="preview">
        <div class="preview__img">
          <img src="${img}">
        </div>
        <div class="preview__delete">
          <div class="preview__delete--button">
            <p>削除</p>
          </div>
        </div>
      </div>`;
    $(".dropbox").prepend(html);
  };

  $(".dropbox__img").on("drop", e => {
    e.preventDefault();
    e.stopPropagation();
    let dropImg = e.originalEvent.dataTransfer.files;
    let previewCount = $(".preview").length;
    let fileImput = $("#sell-img")[0];
    if (dropImg.length == 1) {
      if (previewCount <= 9) {
        let img = URL.createObjectURL(dropImg[0]);
        previewHTML(img);
        images.push(dropImg[0].name);
        fileImput.files = dropImg;
        if (previewCount == 9) {
          $(".dropbox__img").remove();
        }
      }
    } else {
      alert("1枚づつ入れてね！");
    }
  });

  $(document).on("click", ".preview__delete--button", function() {
    $(this).closest(".preview").remove();
  });

  $(document).on("drop", e => {
    e.stopPropagation();
    e.preventDefault();
  });
  $(document).on("dragenter", e => {
    e.stopPropagation();
    e.preventDefault();
  });
  $(document).on("dragover", e => {
    e.stopPropagation();
    e.preventDefault();
  });
});
