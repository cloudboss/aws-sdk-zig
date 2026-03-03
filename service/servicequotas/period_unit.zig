const std = @import("std");

pub const PeriodUnit = enum {
    microsecond,
    millisecond,
    second,
    minute,
    hour,
    day,
    week,

    pub const json_field_names = .{
        .microsecond = "MICROSECOND",
        .millisecond = "MILLISECOND",
        .second = "SECOND",
        .minute = "MINUTE",
        .hour = "HOUR",
        .day = "DAY",
        .week = "WEEK",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .microsecond => "MICROSECOND",
            .millisecond => "MILLISECOND",
            .second => "SECOND",
            .minute => "MINUTE",
            .hour => "HOUR",
            .day => "DAY",
            .week => "WEEK",
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
