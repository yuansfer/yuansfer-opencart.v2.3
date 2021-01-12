<h2><?php echo $text_payment_info; ?></h2>
<table class="table table-striped table-bordered">
  <tr>
    <td><?php echo $text_reference; ?></td>
    <td><?php echo $yuansfer_order['yuansfer_transaction_no']; ?></td>
  </tr>
  <tr>
    <td><?php echo $text_order_total; ?></td>
    <td><?php echo $yuansfer_order['total']; ?></td>
  </tr>
  <tr>
    <td><?php echo $text_refund_status; ?></td>
    <td>
      <input type="text" id="refund-amount" name="refund_amount" placeholder="<?php echo $text_refund_amount; ?>" class="form-control" />
      <br />
      <a class="button btn btn-primary" id="button-refund"><?php echo $button_refund; ?></a> 
    </td>
  </tr>
  <tr>
    <td><?php echo $text_transactions; ?>:</td>
    <td><table class="table table-striped table-bordered" id="yuansfer_transactions">
        <thead>
          <tr>
            <td class="text-left"><strong><?php echo $text_column_date_added; ?></strong></td>
            <td class="text-left"><strong><?php echo $text_column_type; ?></strong></td>
            <td class="text-left"><strong><?php echo $text_column_amount; ?></strong></td>
          </tr>
        </thead>
        <tbody>
          <?php foreach($yuansfer_order['transactions'] as $transaction) { ?>
          <tr>
            <td class="text-left"><?php echo $transaction['date_added']; ?></td>
            <td class="text-left"><?php echo $transaction['type']; ?></td>
            <td class="text-left"><?php echo $transaction['amount']; ?></td>
          </tr>
          <?php } ?>
        </tbody>
      </table></td>
  </tr>
</table>
<script type="text/javascript"><!--
$("#button-refund").on('click', function () {
    if (confirm("<?php echo $text_confirm_refund; ?>")) {
        if (!$('#refund-amount').val()) {
            alert('Please enter a valid refund amount!');
        } else {
            $.ajax({
                url: 'index.php?route=extension/payment/yuansfer/refund&order_id=<?php echo $order_id; ?>&token=<?php echo $token; ?>',
                type: 'post',
                data: $('#refund-amount'),
                dataType: 'json',
                cache: false,
                success: function(json) {
                    if (json['success']) {
                        alert(json['success']);
                        location.reload();
                    } else if (json['error']) {
                        alert(json['error']);
                    }
                }
            });
        }
    }
});
//--></script>