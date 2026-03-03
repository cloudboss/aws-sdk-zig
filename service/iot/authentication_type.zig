const std = @import("std");

pub const AuthenticationType = enum {
    custom_auth_x509,
    custom_auth,
    aws_x509,
    aws_sigv4,
    default,

    pub const json_field_names = .{
        .custom_auth_x509 = "CUSTOM_AUTH_X509",
        .custom_auth = "CUSTOM_AUTH",
        .aws_x509 = "AWS_X509",
        .aws_sigv4 = "AWS_SIGV4",
        .default = "DEFAULT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .custom_auth_x509 => "CUSTOM_AUTH_X509",
            .custom_auth => "CUSTOM_AUTH",
            .aws_x509 => "AWS_X509",
            .aws_sigv4 => "AWS_SIGV4",
            .default => "DEFAULT",
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
