const std = @import("std");

pub const DeviceConnectionStatus = enum {
    online,
    offline,
    awaiting_credentials,
    not_available,
    @"error",

    pub const json_field_names = .{
        .online = "ONLINE",
        .offline = "OFFLINE",
        .awaiting_credentials = "AWAITING_CREDENTIALS",
        .not_available = "NOT_AVAILABLE",
        .@"error" = "ERROR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .online => "ONLINE",
            .offline => "OFFLINE",
            .awaiting_credentials => "AWAITING_CREDENTIALS",
            .not_available => "NOT_AVAILABLE",
            .@"error" => "ERROR",
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
