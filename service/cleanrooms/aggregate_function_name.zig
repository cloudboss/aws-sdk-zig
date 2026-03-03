const std = @import("std");

pub const AggregateFunctionName = enum {
    sum,
    sum_distinct,
    count,
    count_distinct,
    avg,

    pub const json_field_names = .{
        .sum = "SUM",
        .sum_distinct = "SUM_DISTINCT",
        .count = "COUNT",
        .count_distinct = "COUNT_DISTINCT",
        .avg = "AVG",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .sum => "SUM",
            .sum_distinct => "SUM_DISTINCT",
            .count => "COUNT",
            .count_distinct => "COUNT_DISTINCT",
            .avg => "AVG",
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
