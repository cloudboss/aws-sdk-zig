const std = @import("std");

pub const Statistic = enum {
    average,
    sum,
    sample_count,
    maximum,
    minimum,

    pub const json_field_names = .{
        .average = "Average",
        .sum = "Sum",
        .sample_count = "SampleCount",
        .maximum = "Maximum",
        .minimum = "Minimum",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .average => "Average",
            .sum => "Sum",
            .sample_count => "SampleCount",
            .maximum => "Maximum",
            .minimum => "Minimum",
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
