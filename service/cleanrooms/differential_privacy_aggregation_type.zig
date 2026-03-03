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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
