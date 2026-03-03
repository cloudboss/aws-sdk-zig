const std = @import("std");

pub const Frequency = enum {
    once,
    hourly,
    daily,
    weekly,
    monthly,
    event,
    in_app_event,

    pub const json_field_names = .{
        .once = "ONCE",
        .hourly = "HOURLY",
        .daily = "DAILY",
        .weekly = "WEEKLY",
        .monthly = "MONTHLY",
        .event = "EVENT",
        .in_app_event = "IN_APP_EVENT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .once => "ONCE",
            .hourly => "HOURLY",
            .daily => "DAILY",
            .weekly => "WEEKLY",
            .monthly => "MONTHLY",
            .event => "EVENT",
            .in_app_event => "IN_APP_EVENT",
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
