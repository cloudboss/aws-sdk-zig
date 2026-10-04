const std = @import("std");

pub const RetentionPeriodType = enum {
    seconds,
    minutes,
    hours,
    days,
    months,
    years,
    infinite,
    unspecified,

    pub const json_field_names = .{
        .seconds = "SECONDS",
        .minutes = "MINUTES",
        .hours = "HOURS",
        .days = "DAYS",
        .months = "MONTHS",
        .years = "YEARS",
        .infinite = "INFINITE",
        .unspecified = "UNSPECIFIED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .seconds => "SECONDS",
            .minutes => "MINUTES",
            .hours => "HOURS",
            .days => "DAYS",
            .months => "MONTHS",
            .years => "YEARS",
            .infinite => "INFINITE",
            .unspecified => "UNSPECIFIED",
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
