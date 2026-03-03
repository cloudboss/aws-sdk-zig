const std = @import("std");

pub const ValidityType = enum {
    days,
    months,
    years,

    pub const json_field_names = .{
        .days = "DAYS",
        .months = "MONTHS",
        .years = "YEARS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .days => "DAYS",
            .months => "MONTHS",
            .years => "YEARS",
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
