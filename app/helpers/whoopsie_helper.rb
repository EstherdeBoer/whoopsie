module WhoopsieHelper
  def whoopsie_config
    (<<-EOS).strip_heredoc.html_safe
      <script>
        window.Whoopsie = window.Whoopsie || {};
        window.Whoopsie.enabled                 = #{Rails.application.config.whoopsie.enable.to_json};
        window.Whoopsie.client_notification_url = "#{errors_path}";
      </script>
    EOS
  end
end
