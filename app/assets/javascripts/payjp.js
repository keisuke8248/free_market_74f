document.addEventListener(
  "DOMContentLoaded", e => {
    if (document.getElementById("token_submit") != null) {
      Payjp.setPublicKey("pk_test_17f2f80ac0b9fc7c17a70eff");
      let btn = document.getElementById("token_submit");
      btn.addEventListener("click", e => {
        e.preventDefault();
        let card = {
          number: document.getElementById("card_number").value,
          cvc: document.getElementById("cvc").value,
          exp_month: document.getElementById("exp_month").value,
          exp_year: document.getElementById("exp_year").value
        };
        Payjp.createToken(card, (status, response) => {
          if (status === 200) {
            $("#card_number").removeAttr("name");
            $("#cvc").removeAttr("name");
            $("#exp_month").removeAttr("name");
            $("#exp_year").removeAttr("name");
            $("#card_token").append(
              $('<input type="hidden" name="payjp-token">').val(response.id)
            );
            document.inputForm.submit();
          } else {
            $("#alert").empty();
            $(".blank__alert").empty();

            let message = "必須項目です"

            if ((card['number']) == "") {
              $('#number').append(message);
            } 
            if ((card['exp_month']) == "" || (card['exp_year']) == "") {
              $('#date').append(message);
            } 
            if ((card['cvc']) == "") {
              $('#cvc_number').append(message);
            }
            if ((card['number']) != "" &&
                (card['exp_month']) != "" &&
                (card['exp_year']) != "" &&
                (card['cvc']) != "") {
                  $("#card_number").val("");
                  $("#cvc").val("");
                  $("#exp_month").val("");
                  $("#exp_year").val("");
                  $("#alert").append("カード情報が正しくありません");
                }
          }
        });
      });
    }
  },
  false
);
