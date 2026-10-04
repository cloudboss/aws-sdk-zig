const std = @import("std");

pub const RelativeFontSize = enum {
    extra_small,
    small,
    medium,
    large,
    extra_large,

    pub const json_field_names = .{
        .extra_small = "EXTRA_SMALL",
        .small = "SMALL",
        .medium = "MEDIUM",
        .large = "LARGE",
        .extra_large = "EXTRA_LARGE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .extra_small => "EXTRA_SMALL",
            .small => "SMALL",
            .medium => "MEDIUM",
            .large => "LARGE",
            .extra_large => "EXTRA_LARGE",
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
