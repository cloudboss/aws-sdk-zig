const std = @import("std");

pub const ReportFrequencyType = enum {
    day,
    week,
    month,
    one_time,

    pub const json_field_names = .{
        .day = "DAY",
        .week = "WEEK",
        .month = "MONTH",
        .one_time = "ONE_TIME",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .day => "DAY",
            .week => "WEEK",
            .month => "MONTH",
            .one_time => "ONE_TIME",
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
