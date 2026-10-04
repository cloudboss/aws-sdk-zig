const std = @import("std");

pub const ConnectionType = enum {
    websocket,
    connection_credentials,
    authentication_session,
    webrtc_connection,

    pub const json_field_names = .{
        .websocket = "WEBSOCKET",
        .connection_credentials = "CONNECTION_CREDENTIALS",
        .authentication_session = "AUTHENTICATION_SESSION",
        .webrtc_connection = "WEBRTC_CONNECTION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .websocket => "WEBSOCKET",
            .connection_credentials => "CONNECTION_CREDENTIALS",
            .authentication_session => "AUTHENTICATION_SESSION",
            .webrtc_connection => "WEBRTC_CONNECTION",
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
