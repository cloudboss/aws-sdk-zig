const std = @import("std");

pub const FieldAggregationType = enum {
    min,
    max,
    sum,
    avg,
    count,

    pub const json_field_names = .{
        .min = "Min",
        .max = "Max",
        .sum = "Sum",
        .avg = "Avg",
        .count = "Count",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .min => "Min",
            .max => "Max",
            .sum => "Sum",
            .avg => "Avg",
            .count => "Count",
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
