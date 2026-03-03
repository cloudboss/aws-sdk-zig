const std = @import("std");

pub const DateAggregationFunction = enum {
    count,
    distinct_count,
    min,
    max,

    pub const json_field_names = .{
        .count = "COUNT",
        .distinct_count = "DISTINCT_COUNT",
        .min = "MIN",
        .max = "MAX",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .count => "COUNT",
            .distinct_count => "DISTINCT_COUNT",
            .min => "MIN",
            .max => "MAX",
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
