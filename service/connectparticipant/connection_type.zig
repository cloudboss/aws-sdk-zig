const std = @import("std");

pub const ConnectionType = enum {
    websocket,
    connection_credentials,
    webrtc_connection,

    pub const json_field_names = .{
        .websocket = "WEBSOCKET",
        .connection_credentials = "CONNECTION_CREDENTIALS",
        .webrtc_connection = "WEBRTC_CONNECTION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .websocket => "WEBSOCKET",
            .connection_credentials => "CONNECTION_CREDENTIALS",
            .webrtc_connection => "WEBRTC_CONNECTION",
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
