const std = @import("std");

pub const AuthorSpecifiedAggregation = enum {
    count,
    distinct_count,
    min,
    max,
    median,
    sum,
    average,
    stdev,
    stdevp,
    @"var",
    varp,
    percentile,

    pub const json_field_names = .{
        .count = "COUNT",
        .distinct_count = "DISTINCT_COUNT",
        .min = "MIN",
        .max = "MAX",
        .median = "MEDIAN",
        .sum = "SUM",
        .average = "AVERAGE",
        .stdev = "STDEV",
        .stdevp = "STDEVP",
        .@"var" = "VAR",
        .varp = "VARP",
        .percentile = "PERCENTILE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .count => "COUNT",
            .distinct_count => "DISTINCT_COUNT",
            .min => "MIN",
            .max => "MAX",
            .median => "MEDIAN",
            .sum => "SUM",
            .average => "AVERAGE",
            .stdev => "STDEV",
            .stdevp => "STDEVP",
            .@"var" => "VAR",
            .varp => "VARP",
            .percentile => "PERCENTILE",
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
