const std = @import("std");

/// The connectivity status of a CSPM connector.
pub const CspmConnectorStatus = enum {
    connected,
    degraded,
    failed_to_connect,
    unknown,

    pub const json_field_names = .{
        .connected = "CONNECTED",
        .degraded = "DEGRADED",
        .failed_to_connect = "FAILED_TO_CONNECT",
        .unknown = "UNKNOWN",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .connected => "CONNECTED",
            .degraded => "DEGRADED",
            .failed_to_connect => "FAILED_TO_CONNECT",
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
