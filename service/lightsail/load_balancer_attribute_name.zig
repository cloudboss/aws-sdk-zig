const std = @import("std");

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

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .health_check_path => "HealthCheckPath",
            .session_stickiness_enabled => "SessionStickinessEnabled",
            .session_stickiness_lb_cookie_duration_seconds => "SessionStickiness_LB_CookieDurationSeconds",
            .https_redirection_enabled => "HttpsRedirectionEnabled",
            .tls_policy_name => "TlsPolicyName",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
