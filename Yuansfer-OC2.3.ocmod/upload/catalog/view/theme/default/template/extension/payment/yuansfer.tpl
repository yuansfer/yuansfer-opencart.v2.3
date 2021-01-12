<?php if ($testmode) { ?>
<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $text_testmode; ?></div>
<?php } ?>
<div class="row">
  <div class="form-group required">
    <label class="col-sm-4 control-label" for="input-yuansfer-merchant"><?php echo $entry_merchants; ?></label>
    <div class="col-sm-8">
      <select name="yuansfer_merchant" id="input-yuansfer-merchant" class="form-control">
        <?php foreach ($payment_methods as $payment_method) { ?>
        <option value="<?php echo $payment_method; ?>"><?php echo ${'text_' . $payment_method}; ?></option>
        <?php } ?>
      </select>
    </div>
  </div>
</div>
<div class="buttons">
  <div class="pull-right">
    <button type="button" id="button-confirm" onclick="submitPayment();" class="btn btn-primary"><?php echo $button_confirm; ?></button>
  </div>
</div>
<script type="text/javascript"><!--
function submitPayment() {
    $.ajax({
        url: 'index.php?route=extension/payment/yuansfer/submitPayment&mobile=' + ($(window).width() < 768 ? '1' : '0'),
        type: 'post',
        data: $('#input-yuansfer-merchant'),
        dataType: 'json',
        beforeSend: function() {
            $('#button-confirm').button('loading');
        },
        success: function(json) {
            $('.text-danger').remove();
            $('.form-group').removeClass('has-error');

            if (json['error']) {
                $('#input-yuansfer-merchant').parent().addClass('has-error');
                $('#input-yuansfer-merchant').after('<div class="text-danger">' + json['error'] + '</div>');
                $('#button-confirm').button('reset');
            } else if (json['redirect']) {
                window.location.href = json['redirect'];
            } else {
                alert('<?php echo $error_unknown; ?>');
                $('#button-confirm').button('reset');
            }
        },
        error: function(xhr, ajaxOptions, thrownError) {
            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
        }
    });
}
//--></script>
