const std = @import("std");

pub const AuthenticationType = enum {
    api,
    saml,
    userpool,
    aws_ad,

    pub const json_field_names = .{
        .api = "API",
        .saml = "SAML",
        .userpool = "USERPOOL",
        .aws_ad = "AWS_AD",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .api => "API",
            .saml => "SAML",
            .userpool => "USERPOOL",
            .aws_ad => "AWS_AD",
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
