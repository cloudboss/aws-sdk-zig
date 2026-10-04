const std = @import("std");

pub const StreamSessionStatus = enum {
    activating,
    active,
    connected,
    pending_client_reconnection,
    reconnecting,
    terminating,
    terminated,
    @"error",

    pub const json_field_names = .{
        .activating = "ACTIVATING",
        .active = "ACTIVE",
        .connected = "CONNECTED",
        .pending_client_reconnection = "PENDING_CLIENT_RECONNECTION",
        .reconnecting = "RECONNECTING",
        .terminating = "TERMINATING",
        .terminated = "TERMINATED",
        .@"error" = "ERROR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .activating => "ACTIVATING",
            .active => "ACTIVE",
            .connected => "CONNECTED",
            .pending_client_reconnection => "PENDING_CLIENT_RECONNECTION",
            .reconnecting => "RECONNECTING",
            .terminating => "TERMINATING",
            .terminated => "TERMINATED",
            .@"error" => "ERROR",
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
