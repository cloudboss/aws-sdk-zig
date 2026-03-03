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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
