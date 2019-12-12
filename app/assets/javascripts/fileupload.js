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
    if (dropImg.length == 1) {
      if (previewCount <= 9) {
        for (let i = 0; i < dropImg.length; i++) {
          let img = URL.createObjectURL(dropImg[i]);
          previewHTML(img);
          images.push(dropImg[i].name);
          if (previewCount == 9) {
            $(".dropbox__img").remove();
          }
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
