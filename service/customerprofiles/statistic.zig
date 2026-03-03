const std = @import("std");

pub const Statistic = enum {
    first_occurrence,
    last_occurrence,
    count,
    sum,
    minimum,
    maximum,
    average,
    max_occurrence,

    pub const json_field_names = .{
        .first_occurrence = "FIRST_OCCURRENCE",
        .last_occurrence = "LAST_OCCURRENCE",
        .count = "COUNT",
        .sum = "SUM",
        .minimum = "MINIMUM",
        .maximum = "MAXIMUM",
        .average = "AVERAGE",
        .max_occurrence = "MAX_OCCURRENCE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .first_occurrence => "FIRST_OCCURRENCE",
            .last_occurrence => "LAST_OCCURRENCE",
            .count => "COUNT",
            .sum => "SUM",
            .minimum => "MINIMUM",
            .maximum => "MAXIMUM",
            .average => "AVERAGE",
            .max_occurrence => "MAX_OCCURRENCE",
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
