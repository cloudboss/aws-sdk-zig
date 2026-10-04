const std = @import("std");

pub const DbBackupType = enum {
    hourly,
    daily,
    weekly,
    monthly,
    custom_schedule,
    on_demand,
    continuous,

    pub const json_field_names = .{
        .hourly = "HOURLY",
        .daily = "DAILY",
        .weekly = "WEEKLY",
        .monthly = "MONTHLY",
        .custom_schedule = "CUSTOM_SCHEDULE",
        .on_demand = "ON_DEMAND",
        .continuous = "CONTINUOUS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .hourly => "HOURLY",
            .daily => "DAILY",
            .weekly => "WEEKLY",
            .monthly => "MONTHLY",
            .custom_schedule => "CUSTOM_SCHEDULE",
            .on_demand => "ON_DEMAND",
            .continuous => "CONTINUOUS",
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
