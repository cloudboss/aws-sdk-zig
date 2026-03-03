const std = @import("std");

pub const ExplicitAuthFlowsType = enum {
    admin_no_srp_auth,
    custom_auth_flow_only,
    user_password_auth,
    allow_admin_user_password_auth,
    allow_custom_auth,
    allow_user_password_auth,
    allow_user_srp_auth,
    allow_refresh_token_auth,
    allow_user_auth,

    pub const json_field_names = .{
        .admin_no_srp_auth = "ADMIN_NO_SRP_AUTH",
        .custom_auth_flow_only = "CUSTOM_AUTH_FLOW_ONLY",
        .user_password_auth = "USER_PASSWORD_AUTH",
        .allow_admin_user_password_auth = "ALLOW_ADMIN_USER_PASSWORD_AUTH",
        .allow_custom_auth = "ALLOW_CUSTOM_AUTH",
        .allow_user_password_auth = "ALLOW_USER_PASSWORD_AUTH",
        .allow_user_srp_auth = "ALLOW_USER_SRP_AUTH",
        .allow_refresh_token_auth = "ALLOW_REFRESH_TOKEN_AUTH",
        .allow_user_auth = "ALLOW_USER_AUTH",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .admin_no_srp_auth => "ADMIN_NO_SRP_AUTH",
            .custom_auth_flow_only => "CUSTOM_AUTH_FLOW_ONLY",
            .user_password_auth => "USER_PASSWORD_AUTH",
            .allow_admin_user_password_auth => "ALLOW_ADMIN_USER_PASSWORD_AUTH",
            .allow_custom_auth => "ALLOW_CUSTOM_AUTH",
            .allow_user_password_auth => "ALLOW_USER_PASSWORD_AUTH",
            .allow_user_srp_auth => "ALLOW_USER_SRP_AUTH",
            .allow_refresh_token_auth => "ALLOW_REFRESH_TOKEN_AUTH",
            .allow_user_auth => "ALLOW_USER_AUTH",
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
