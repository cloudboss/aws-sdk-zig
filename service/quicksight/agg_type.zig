const std = @import("std");

pub const AggType = enum {
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
    ptd_sum,
    ptd_min,
    ptd_max,
    ptd_count,
    ptd_distinct_count,
    ptd_average,
    column,
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
        .ptd_sum = "PTD_SUM",
        .ptd_min = "PTD_MIN",
        .ptd_max = "PTD_MAX",
        .ptd_count = "PTD_COUNT",
        .ptd_distinct_count = "PTD_DISTINCT_COUNT",
        .ptd_average = "PTD_AVERAGE",
        .column = "COLUMN",
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
            .ptd_sum => "PTD_SUM",
            .ptd_min => "PTD_MIN",
            .ptd_max => "PTD_MAX",
            .ptd_count => "PTD_COUNT",
            .ptd_distinct_count => "PTD_DISTINCT_COUNT",
            .ptd_average => "PTD_AVERAGE",
            .column => "COLUMN",
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
