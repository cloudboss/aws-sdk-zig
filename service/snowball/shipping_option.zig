const std = @import("std");

pub const ShippingOption = enum {
    second_day,
    next_day,
    express,
    standard,

    pub const json_field_names = .{
        .second_day = "SECOND_DAY",
        .next_day = "NEXT_DAY",
        .express = "EXPRESS",
        .standard = "STANDARD",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .second_day => "SECOND_DAY",
            .next_day => "NEXT_DAY",
            .express => "EXPRESS",
            .standard => "STANDARD",
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
