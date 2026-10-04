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
    recent_occurrences,

    pub const json_field_names = .{
        .first_occurrence = "FIRST_OCCURRENCE",
        .last_occurrence = "LAST_OCCURRENCE",
        .count = "COUNT",
        .sum = "SUM",
        .minimum = "MINIMUM",
        .maximum = "MAXIMUM",
        .average = "AVERAGE",
        .max_occurrence = "MAX_OCCURRENCE",
        .recent_occurrences = "RECENT_OCCURRENCES",
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
            .recent_occurrences => "RECENT_OCCURRENCES",
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
