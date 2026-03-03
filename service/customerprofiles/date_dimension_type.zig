const std = @import("std");

pub const DateDimensionType = enum {
    before,
    after,
    between,
    not_between,
    on,

    pub const json_field_names = .{
        .before = "BEFORE",
        .after = "AFTER",
        .between = "BETWEEN",
        .not_between = "NOT_BETWEEN",
        .on = "ON",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .before => "BEFORE",
            .after => "AFTER",
            .between => "BETWEEN",
            .not_between => "NOT_BETWEEN",
            .on => "ON",
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
