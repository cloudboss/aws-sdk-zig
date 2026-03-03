const std = @import("std");

pub const ActionValue = enum {
    allow,
    block,
    count,
    captcha,
    challenge,
    excluded_as_count,

    pub const json_field_names = .{
        .allow = "ALLOW",
        .block = "BLOCK",
        .count = "COUNT",
        .captcha = "CAPTCHA",
        .challenge = "CHALLENGE",
        .excluded_as_count = "EXCLUDED_AS_COUNT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .allow => "ALLOW",
            .block => "BLOCK",
            .count => "COUNT",
            .captcha => "CAPTCHA",
            .challenge => "CHALLENGE",
            .excluded_as_count => "EXCLUDED_AS_COUNT",
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
