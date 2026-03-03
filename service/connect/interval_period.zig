const std = @import("std");

pub const IntervalPeriod = enum {
    fifteen_min,
    thirty_min,
    hour,
    day,
    week,
    total,

    pub const json_field_names = .{
        .fifteen_min = "FIFTEEN_MIN",
        .thirty_min = "THIRTY_MIN",
        .hour = "HOUR",
        .day = "DAY",
        .week = "WEEK",
        .total = "TOTAL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .fifteen_min => "FIFTEEN_MIN",
            .thirty_min => "THIRTY_MIN",
            .hour => "HOUR",
            .day => "DAY",
            .week => "WEEK",
            .total => "TOTAL",
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
