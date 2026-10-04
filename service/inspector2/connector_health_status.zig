const std = @import("std");

pub const ConnectorHealthStatus = enum {
    connected,
    degraded,
    failed_to_connect,
    pending_authorization,
    pending_configuration,
    unknown,

    pub const json_field_names = .{
        .connected = "CONNECTED",
        .degraded = "DEGRADED",
        .failed_to_connect = "FAILED_TO_CONNECT",
        .pending_authorization = "PENDING_AUTHORIZATION",
        .pending_configuration = "PENDING_CONFIGURATION",
        .unknown = "UNKNOWN",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .connected => "CONNECTED",
            .degraded => "DEGRADED",
            .failed_to_connect => "FAILED_TO_CONNECT",
            .pending_authorization => "PENDING_AUTHORIZATION",
            .pending_configuration => "PENDING_CONFIGURATION",
            .unknown => "UNKNOWN",
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
