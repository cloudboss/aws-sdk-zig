const std = @import("std");

pub const SimpleNumericalAggregationFunction = enum {
    sum,
    average,
    min,
    max,
    count,
    distinct_count,
    @"var",
    varp,
    stdev,
    stdevp,
    median,

    pub const json_field_names = .{
        .sum = "SUM",
        .average = "AVERAGE",
        .min = "MIN",
        .max = "MAX",
        .count = "COUNT",
        .distinct_count = "DISTINCT_COUNT",
        .@"var" = "VAR",
        .varp = "VARP",
        .stdev = "STDEV",
        .stdevp = "STDEVP",
        .median = "MEDIAN",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .sum => "SUM",
            .average => "AVERAGE",
            .min => "MIN",
            .max => "MAX",
            .count => "COUNT",
            .distinct_count => "DISTINCT_COUNT",
            .@"var" => "VAR",
            .varp => "VARP",
            .stdev => "STDEV",
            .stdevp => "STDEVP",
            .median => "MEDIAN",
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
