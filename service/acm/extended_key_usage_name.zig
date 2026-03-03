const std = @import("std");

pub const ExtendedKeyUsageName = enum {
    tls_web_server_authentication,
    tls_web_client_authentication,
    code_signing,
    email_protection,
    time_stamping,
    ocsp_signing,
    ipsec_end_system,
    ipsec_tunnel,
    ipsec_user,
    any,
    none,
    custom,

    pub const json_field_names = .{
        .tls_web_server_authentication = "TLS_WEB_SERVER_AUTHENTICATION",
        .tls_web_client_authentication = "TLS_WEB_CLIENT_AUTHENTICATION",
        .code_signing = "CODE_SIGNING",
        .email_protection = "EMAIL_PROTECTION",
        .time_stamping = "TIME_STAMPING",
        .ocsp_signing = "OCSP_SIGNING",
        .ipsec_end_system = "IPSEC_END_SYSTEM",
        .ipsec_tunnel = "IPSEC_TUNNEL",
        .ipsec_user = "IPSEC_USER",
        .any = "ANY",
        .none = "NONE",
        .custom = "CUSTOM",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .tls_web_server_authentication => "TLS_WEB_SERVER_AUTHENTICATION",
            .tls_web_client_authentication => "TLS_WEB_CLIENT_AUTHENTICATION",
            .code_signing => "CODE_SIGNING",
            .email_protection => "EMAIL_PROTECTION",
            .time_stamping => "TIME_STAMPING",
            .ocsp_signing => "OCSP_SIGNING",
            .ipsec_end_system => "IPSEC_END_SYSTEM",
            .ipsec_tunnel => "IPSEC_TUNNEL",
            .ipsec_user => "IPSEC_USER",
            .any => "ANY",
            .none => "NONE",
            .custom => "CUSTOM",
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
