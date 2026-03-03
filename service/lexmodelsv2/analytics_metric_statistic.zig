const std = @import("std");

pub const AnalyticsMetricStatistic = enum {
    sum,
    avg,
    max,

    pub const json_field_names = .{
        .sum = "Sum",
        .avg = "Avg",
        .max = "Max",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .sum => "Sum",
            .avg => "Avg",
            .max => "Max",
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
