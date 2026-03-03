const std = @import("std");

pub const NamedEntityAggType = enum {
    sum,
    min,
    max,
    count,
    average,
    distinct_count,
    stdev,
    stdevp,
    @"var",
    varp,
    percentile,
    median,
    custom,

    pub const json_field_names = .{
        .sum = "SUM",
        .min = "MIN",
        .max = "MAX",
        .count = "COUNT",
        .average = "AVERAGE",
        .distinct_count = "DISTINCT_COUNT",
        .stdev = "STDEV",
        .stdevp = "STDEVP",
        .@"var" = "VAR",
        .varp = "VARP",
        .percentile = "PERCENTILE",
        .median = "MEDIAN",
        .custom = "CUSTOM",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .sum => "SUM",
            .min => "MIN",
            .max => "MAX",
            .count => "COUNT",
            .average => "AVERAGE",
            .distinct_count => "DISTINCT_COUNT",
            .stdev => "STDEV",
            .stdevp => "STDEVP",
            .@"var" => "VAR",
            .varp => "VARP",
            .percentile => "PERCENTILE",
            .median => "MEDIAN",
            .custom => "CUSTOM",
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
