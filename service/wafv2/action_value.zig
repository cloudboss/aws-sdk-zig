const std = @import("std");

pub const ActionValue = enum {
    allow,
    block,
    count,
    captcha,
    challenge,
    monetize,
    excluded_as_count,

    pub const json_field_names = .{
        .allow = "ALLOW",
        .block = "BLOCK",
        .count = "COUNT",
        .captcha = "CAPTCHA",
        .challenge = "CHALLENGE",
        .monetize = "MONETIZE",
        .excluded_as_count = "EXCLUDED_AS_COUNT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .allow => "ALLOW",
            .block => "BLOCK",
            .count => "COUNT",
            .captcha => "CAPTCHA",
            .challenge => "CHALLENGE",
            .monetize => "MONETIZE",
            .excluded_as_count => "EXCLUDED_AS_COUNT",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
