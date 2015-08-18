if (window.Rails.env === "development" || window.Rails.env === "test") {
  TraceKit.report.subscribe(function(errorReport) {
    console.log('TraceKit report', JSON.stringify(errorReport))
  })

  TraceKit.wrap = function(func) {
    function wrapped() {
      return func.apply(this, arguments);
    }
    return wrapped;
  }
} else {
  TraceKit.report.subscribe(function(errorReport) {
    jQuery.ajax({
      url: "/errors",
      type: "POST",
      data: {
        error_report: errorReport,
        extra: window.loggingInformation
      }
    });
    return true;
  });

  jQuery.extend({
    error: function(msg) {
      var error;
      error = new Error(msg);
      TraceKit.report(error);
      return null;
    }
  });
}

TraceKit.run = function(func){
  TraceKit.wrap(func).apply(this, arguments)
}

$.ajaxSettings.converters["text script"] = TraceKit.wrap(window.eval)
