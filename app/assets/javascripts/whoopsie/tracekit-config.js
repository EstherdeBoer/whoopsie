if (typeof window.Whoopsie !== "object") {
  alert("Error notifications not configured. Did you include whoopsie_helper?")
}

if (window.Whoopsie && window.Whoopsie.enabled) {
  TraceKit.report.subscribe(function(errorReport) {
    jQuery.ajax({
      url: window.Whoopsie.client_notification_url,
      type: "POST",
      data: {
        error_report: errorReport,
        extra: Whoopsie.extra(),
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
} else {
  TraceKit.report.subscribe(function(errorReport) {
    console.log('TraceKit report', JSON.stringify(errorReport))
  })

  TraceKit.wrap = function(func) {
    function wrapped() {
      return func.apply(this, arguments);
    }
    return wrapped;
  }
}

TraceKit.run = function(func){
  TraceKit.wrap(func).apply(this, arguments)
}

Whoopsie.wrap = TraceKit.wrap;

Whoopsie.run = function(func){
  Whoopsie.wrap(func).apply(this, arguments)
}


$.ajaxSettings.converters["text script"] = TraceKit.wrap(window.eval)
