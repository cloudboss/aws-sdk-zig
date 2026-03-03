const std = @import("std");

pub const NamedFilterAggType = enum {
    no_aggregation,
    sum,
    average,
    count,
    distinct_count,
    max,
    median,
    min,
    stdev,
    stdevp,
    @"var",
    varp,

    pub const json_field_names = .{
        .no_aggregation = "NO_AGGREGATION",
        .sum = "SUM",
        .average = "AVERAGE",
        .count = "COUNT",
        .distinct_count = "DISTINCT_COUNT",
        .max = "MAX",
        .median = "MEDIAN",
        .min = "MIN",
        .stdev = "STDEV",
        .stdevp = "STDEVP",
        .@"var" = "VAR",
        .varp = "VARP",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .no_aggregation => "NO_AGGREGATION",
            .sum => "SUM",
            .average => "AVERAGE",
            .count => "COUNT",
            .distinct_count => "DISTINCT_COUNT",
            .max => "MAX",
            .median => "MEDIAN",
            .min => "MIN",
            .stdev => "STDEV",
            .stdevp => "STDEVP",
            .@"var" => "VAR",
            .varp => "VARP",
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
