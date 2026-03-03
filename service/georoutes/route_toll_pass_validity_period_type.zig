const std = @import("std");

pub const RouteTollPassValidityPeriodType = enum {
    annual,
    days,
    extended_annual,
    minutes,
    months,

    pub const json_field_names = .{
        .annual = "Annual",
        .days = "Days",
        .extended_annual = "ExtendedAnnual",
        .minutes = "Minutes",
        .months = "Months",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .annual => "Annual",
            .days => "Days",
            .extended_annual => "ExtendedAnnual",
            .minutes => "Minutes",
            .months => "Months",
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
