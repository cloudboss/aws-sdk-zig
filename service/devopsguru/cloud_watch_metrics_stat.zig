const std = @import("std");

pub const CloudWatchMetricsStat = enum {
    sum,
    average,
    sample_count,
    minimum,
    maximum,
    p99,
    p90,
    p50,

    pub const json_field_names = .{
        .sum = "Sum",
        .average = "Average",
        .sample_count = "SampleCount",
        .minimum = "Minimum",
        .maximum = "Maximum",
        .p99 = "p99",
        .p90 = "p90",
        .p50 = "p50",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .sum => "Sum",
            .average => "Average",
            .sample_count => "SampleCount",
            .minimum => "Minimum",
            .maximum => "Maximum",
            .p99 => "p99",
            .p90 => "p90",
            .p50 => "p50",
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
