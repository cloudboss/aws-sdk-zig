const std = @import("std");

pub const AggFunction = enum {
    avg,
    count_distinct,
    count,
    first,
    last,
    kurtosis,
    max,
    min,
    skewness,
    stddev_samp,
    stddev_pop,
    sum,
    sum_distinct,
    var_samp,
    var_pop,

    pub const json_field_names = .{
        .avg = "avg",
        .count_distinct = "countDistinct",
        .count = "count",
        .first = "first",
        .last = "last",
        .kurtosis = "kurtosis",
        .max = "max",
        .min = "min",
        .skewness = "skewness",
        .stddev_samp = "stddev_samp",
        .stddev_pop = "stddev_pop",
        .sum = "sum",
        .sum_distinct = "sumDistinct",
        .var_samp = "var_samp",
        .var_pop = "var_pop",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .avg => "avg",
            .count_distinct => "countDistinct",
            .count => "count",
            .first => "first",
            .last => "last",
            .kurtosis => "kurtosis",
            .max => "max",
            .min => "min",
            .skewness => "skewness",
            .stddev_samp => "stddev_samp",
            .stddev_pop => "stddev_pop",
            .sum => "sum",
            .sum_distinct => "sumDistinct",
            .var_samp => "var_samp",
            .var_pop => "var_pop",
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
