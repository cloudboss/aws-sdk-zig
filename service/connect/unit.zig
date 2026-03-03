const std = @import("std");

pub const Unit = enum {
    seconds,
    count,
    percent,

    pub const json_field_names = .{
        .seconds = "SECONDS",
        .count = "COUNT",
        .percent = "PERCENT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .seconds => "SECONDS",
            .count => "COUNT",
            .percent => "PERCENT",
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
