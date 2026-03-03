const std = @import("std");

pub const PeriodType = enum {
    five_minutes,
    fifteen_minutes,
    one_hour,
    three_hours,
    one_day,
    one_week,

    pub const json_field_names = .{
        .five_minutes = "five-minutes",
        .fifteen_minutes = "fifteen-minutes",
        .one_hour = "one-hour",
        .three_hours = "three-hours",
        .one_day = "one-day",
        .one_week = "one-week",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .five_minutes => "five-minutes",
            .fifteen_minutes => "fifteen-minutes",
            .one_hour => "one-hour",
            .three_hours => "three-hours",
            .one_day => "one-day",
            .one_week => "one-week",
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
