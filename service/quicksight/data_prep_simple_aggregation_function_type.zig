const std = @import("std");

pub const DataPrepSimpleAggregationFunctionType = enum {
    count,
    distinct_count,
    sum,
    average,
    max,
    min,

    pub const json_field_names = .{
        .count = "COUNT",
        .distinct_count = "DISTINCT_COUNT",
        .sum = "SUM",
        .average = "AVERAGE",
        .max = "MAX",
        .min = "MIN",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .count => "COUNT",
            .distinct_count => "DISTINCT_COUNT",
            .sum => "SUM",
            .average => "AVERAGE",
            .max => "MAX",
            .min => "MIN",
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
