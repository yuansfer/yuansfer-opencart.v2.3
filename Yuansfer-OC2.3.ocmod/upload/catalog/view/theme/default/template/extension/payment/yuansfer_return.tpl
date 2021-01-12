<?php echo $header; ?>
<div id="container" class="container j-container">
  <ul class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php } ?>
  </ul>
  <div class="row"><?php echo $column_left; ?><?php echo $column_right; ?>
    <?php if ($column_left && $column_right) { ?>
    <?php $class = 'col-sm-6'; ?>
    <?php } elseif ($column_left || $column_right) { ?>
    <?php $class = 'col-sm-9'; ?>
    <?php } else { ?>
    <?php $class = 'col-sm-12'; ?>
    <?php } ?>
    <div id="content" class="<?php echo $class; ?>">
      <h1 class="heading-title"><?php echo $heading_title; ?></h1>
      <?php echo $content_top; ?>
      <div id="yuansfer-message" style="font-size:24px;text-align:center;">
        <?php if (!$failed) { ?>
        <i class="fa fa-spinner fa-spin" style="font-size:60px;"></i><br /><br />
        <?php } ?>
        <?php echo $description; ?>
        <?php if ($failed) { ?>
        <br /><br />
        <?php echo $message; ?>
        <br /><br />
        <a href="<?php echo $checkout; ?>" class="btn btn-primary"><?php echo $button_checkout; ?></a><br /><br />
        <?php } ?>
      </div>
      <?php echo $content_bottom; ?>
    </div>
    </div>
</div>
<?php if (!$failed) { ?>
<script type="text/javascript">
var enquireStatus = setInterval(function() {
    $.ajax({
        url: 'index.php?route=extension/payment/yuansfer/status',
        type: 'get',
        dataType: 'json',
        cache: false,
        success: function(json) {
            if (typeof json['status'] !== 'undefined') {
                if (json['message']) {
                    $('#yuansfer-message').html(json['message']);
                }
                
                clearInterval(enquireStatus);
                
                setTimeout(function() {
                    if (json['status']) {
                        location = '<?php echo $success_location; ?>';
                    } else {
                        location = '<?php echo $failed_location; ?>&message=' + encodeURIComponent(json['message']);
                    }
                }, 2000);
            }
            
            if (typeof json['failed'] !== 'undefined' && json['failed']) {
                location = '<?php echo $unknown_location; ?>';
            }
        }
    });
}, 1500);
</script>
<?php } ?>
<?php echo $footer; ?> 