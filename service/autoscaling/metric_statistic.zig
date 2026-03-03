const std = @import("std");

pub const MetricStatistic = enum {
    average,
    minimum,
    maximum,
    sample_count,
    sum,

    pub const json_field_names = .{
        .average = "Average",
        .minimum = "Minimum",
        .maximum = "Maximum",
        .sample_count = "SampleCount",
        .sum = "Sum",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .average => "Average",
            .minimum => "Minimum",
            .maximum => "Maximum",
            .sample_count => "SampleCount",
            .sum => "Sum",
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
