const std = @import("std");

pub const AuthenticationProviderTypes = enum {
    /// Indicates that AMG workspace has AWS SSO enabled as its authentication
    /// provider.
    aws_sso,
    /// Indicates that the AMG workspace has SAML enabled as its authentication
    /// provider.
    saml,

    pub const json_field_names = .{
        .aws_sso = "AWS_SSO",
        .saml = "SAML",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .aws_sso => "AWS_SSO",
            .saml => "SAML",
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
