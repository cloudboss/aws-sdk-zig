const std = @import("std");

pub const AutomatedDbBackupType = enum {
    hourly,
    daily,
    weekly,
    monthly,
    custom_schedule,
    continuous,

    pub const json_field_names = .{
        .hourly = "HOURLY",
        .daily = "DAILY",
        .weekly = "WEEKLY",
        .monthly = "MONTHLY",
        .custom_schedule = "CUSTOM_SCHEDULE",
        .continuous = "CONTINUOUS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .hourly => "HOURLY",
            .daily => "DAILY",
            .weekly => "WEEKLY",
            .monthly => "MONTHLY",
            .custom_schedule => "CUSTOM_SCHEDULE",
            .continuous => "CONTINUOUS",
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
