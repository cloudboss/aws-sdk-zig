pub const LoadBalancerAttributeName = enum {
    health_check_path,
    session_stickiness_enabled,
    session_stickiness_lb_cookie_duration_seconds,
    https_redirection_enabled,
    tls_policy_name,

    pub const json_field_names = .{
        .health_check_path = "HealthCheckPath",
        .session_stickiness_enabled = "SessionStickinessEnabled",
        .session_stickiness_lb_cookie_duration_seconds = "SessionStickiness_LB_CookieDurationSeconds",
        .https_redirection_enabled = "HttpsRedirectionEnabled",
        .tls_policy_name = "TlsPolicyName",
    };
};
