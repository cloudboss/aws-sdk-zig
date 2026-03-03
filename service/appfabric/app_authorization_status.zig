const std = @import("std");

pub const AppAuthorizationStatus = enum {
    pending_connect,
    connected,
    connection_validation_failed,
    token_auto_rotation_failed,

    pub const json_field_names = .{
        .pending_connect = "PendingConnect",
        .connected = "Connected",
        .connection_validation_failed = "ConnectionValidationFailed",
        .token_auto_rotation_failed = "TokenAutoRotationFailed",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending_connect => "PendingConnect",
            .connected => "Connected",
            .connection_validation_failed => "ConnectionValidationFailed",
            .token_auto_rotation_failed => "TokenAutoRotationFailed",
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
