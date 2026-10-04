const std = @import("std");

pub const PrefixFormat = enum {
    year,
    month,
    day,
    hour,
    minute,

    pub const json_field_names = .{
        .year = "YEAR",
        .month = "MONTH",
        .day = "DAY",
        .hour = "HOUR",
        .minute = "MINUTE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .year => "YEAR",
            .month => "MONTH",
            .day => "DAY",
            .hour => "HOUR",
            .minute => "MINUTE",
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
