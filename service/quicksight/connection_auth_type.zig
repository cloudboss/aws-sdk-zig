const std = @import("std");

pub const ConnectionAuthType = enum {
    basic,
    api_key,
    oauth2_client_credentials,
    none,
    iam,
    oauth2_authorization_code,

    pub const json_field_names = .{
        .basic = "BASIC",
        .api_key = "API_KEY",
        .oauth2_client_credentials = "OAUTH2_CLIENT_CREDENTIALS",
        .none = "NONE",
        .iam = "IAM",
        .oauth2_authorization_code = "OAUTH2_AUTHORIZATION_CODE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .basic => "BASIC",
            .api_key => "API_KEY",
            .oauth2_client_credentials => "OAUTH2_CLIENT_CREDENTIALS",
            .none => "NONE",
            .iam => "IAM",
            .oauth2_authorization_code => "OAUTH2_AUTHORIZATION_CODE",
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
