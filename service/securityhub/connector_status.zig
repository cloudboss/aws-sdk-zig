const std = @import("std");

pub const ConnectorStatus = enum {
    connected,
    failed_to_connect,
    pending_configuration,
    pending_authorization,

    pub const json_field_names = .{
        .connected = "CONNECTED",
        .failed_to_connect = "FAILED_TO_CONNECT",
        .pending_configuration = "PENDING_CONFIGURATION",
        .pending_authorization = "PENDING_AUTHORIZATION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .connected => "CONNECTED",
            .failed_to_connect => "FAILED_TO_CONNECT",
            .pending_configuration => "PENDING_CONFIGURATION",
            .pending_authorization => "PENDING_AUTHORIZATION",
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
