const std = @import("std");

pub const TopicTimeGranularity = enum {
    second,
    minute,
    hour,
    day,
    week,
    month,
    quarter,
    year,

    pub const json_field_names = .{
        .second = "SECOND",
        .minute = "MINUTE",
        .hour = "HOUR",
        .day = "DAY",
        .week = "WEEK",
        .month = "MONTH",
        .quarter = "QUARTER",
        .year = "YEAR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .second => "SECOND",
            .minute => "MINUTE",
            .hour => "HOUR",
            .day => "DAY",
            .week => "WEEK",
            .month => "MONTH",
            .quarter => "QUARTER",
            .year => "YEAR",
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
