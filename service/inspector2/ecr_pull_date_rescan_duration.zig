const std = @import("std");

pub const EcrPullDateRescanDuration = enum {
    days_14,
    days_30,
    days_60,
    days_90,
    days_180,

    pub const json_field_names = .{
        .days_14 = "DAYS_14",
        .days_30 = "DAYS_30",
        .days_60 = "DAYS_60",
        .days_90 = "DAYS_90",
        .days_180 = "DAYS_180",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .days_14 => "DAYS_14",
            .days_30 => "DAYS_30",
            .days_60 => "DAYS_60",
            .days_90 => "DAYS_90",
            .days_180 => "DAYS_180",
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
