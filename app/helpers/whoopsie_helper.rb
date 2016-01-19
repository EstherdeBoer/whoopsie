module WhoopsieHelper
  def whoopsie_config(extra = {})
    (<<-EOS).strip_heredoc.html_safe
      <script>
        window.Whoopsie = window.Whoopsie || {};
        window.Whoopsie.enabled                 = #{Rails.application.config.whoopsie.enable.to_json};
        window.Whoopsie.client_notification_url = "#{errors_path}";
        window.Whoopsie.extra = function(){
          var extra = #{extra.to_json};
          extra.location = window.location.toString();
          return extra;
        }
      </script>
    EOS
  end
end
