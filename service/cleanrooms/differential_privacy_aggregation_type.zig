const std = @import("std");

pub const DifferentialPrivacyAggregationType = enum {
    avg,
    count,
    count_distinct,
    sum,
    stddev,

    pub const json_field_names = .{
        .avg = "AVG",
        .count = "COUNT",
        .count_distinct = "COUNT_DISTINCT",
        .sum = "SUM",
        .stddev = "STDDEV",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .avg => "AVG",
            .count => "COUNT",
            .count_distinct => "COUNT_DISTINCT",
            .sum => "SUM",
            .stddev => "STDDEV",
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
