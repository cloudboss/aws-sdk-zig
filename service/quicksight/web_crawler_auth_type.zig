const std = @import("std");

pub const WebCrawlerAuthType = enum {
    no_auth,
    basic_auth,
    form,
    saml,

    pub const json_field_names = .{
        .no_auth = "NO_AUTH",
        .basic_auth = "BASIC_AUTH",
        .form = "FORM",
        .saml = "SAML",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .no_auth => "NO_AUTH",
            .basic_auth => "BASIC_AUTH",
            .form => "FORM",
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
