const std = @import("std");

pub const DefaultAggregation = enum {
    sum,
    max,
    min,
    count,
    distinct_count,
    average,
    median,
    stdev,
    stdevp,
    @"var",
    varp,

    pub const json_field_names = .{
        .sum = "SUM",
        .max = "MAX",
        .min = "MIN",
        .count = "COUNT",
        .distinct_count = "DISTINCT_COUNT",
        .average = "AVERAGE",
        .median = "MEDIAN",
        .stdev = "STDEV",
        .stdevp = "STDEVP",
        .@"var" = "VAR",
        .varp = "VARP",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .sum => "SUM",
            .max => "MAX",
            .min => "MIN",
            .count => "COUNT",
            .distinct_count => "DISTINCT_COUNT",
            .average => "AVERAGE",
            .median => "MEDIAN",
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
