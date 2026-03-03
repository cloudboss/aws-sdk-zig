const std = @import("std");

pub const TimeGranularity = enum {
    year,
    quarter,
    month,
    week,
    day,
    hour,
    minute,
    second,
    millisecond,

    pub const json_field_names = .{
        .year = "YEAR",
        .quarter = "QUARTER",
        .month = "MONTH",
        .week = "WEEK",
        .day = "DAY",
        .hour = "HOUR",
        .minute = "MINUTE",
        .second = "SECOND",
        .millisecond = "MILLISECOND",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .year => "YEAR",
            .quarter => "QUARTER",
            .month => "MONTH",
            .week => "WEEK",
            .day => "DAY",
            .hour => "HOUR",
            .minute => "MINUTE",
            .second => "SECOND",
            .millisecond => "MILLISECOND",
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
