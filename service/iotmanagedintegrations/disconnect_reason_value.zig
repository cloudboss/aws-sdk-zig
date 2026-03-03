const std = @import("std");

pub const DisconnectReasonValue = enum {
    auth_error,
    client_initiated_disconnect,
    client_error,
    connection_lost,
    duplicate_clientid,
    forbidden_access,
    mqtt_keep_alive_timeout,
    server_error,
    server_initiated_disconnect,
    throttled,
    websocket_ttl_expiration,
    customauth_ttl_expiration,
    unknown,
    none,

    pub const json_field_names = .{
        .auth_error = "AUTH_ERROR",
        .client_initiated_disconnect = "CLIENT_INITIATED_DISCONNECT",
        .client_error = "CLIENT_ERROR",
        .connection_lost = "CONNECTION_LOST",
        .duplicate_clientid = "DUPLICATE_CLIENTID",
        .forbidden_access = "FORBIDDEN_ACCESS",
        .mqtt_keep_alive_timeout = "MQTT_KEEP_ALIVE_TIMEOUT",
        .server_error = "SERVER_ERROR",
        .server_initiated_disconnect = "SERVER_INITIATED_DISCONNECT",
        .throttled = "THROTTLED",
        .websocket_ttl_expiration = "WEBSOCKET_TTL_EXPIRATION",
        .customauth_ttl_expiration = "CUSTOMAUTH_TTL_EXPIRATION",
        .unknown = "UNKNOWN",
        .none = "NONE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .auth_error => "AUTH_ERROR",
            .client_initiated_disconnect => "CLIENT_INITIATED_DISCONNECT",
            .client_error => "CLIENT_ERROR",
            .connection_lost => "CONNECTION_LOST",
            .duplicate_clientid => "DUPLICATE_CLIENTID",
            .forbidden_access => "FORBIDDEN_ACCESS",
            .mqtt_keep_alive_timeout => "MQTT_KEEP_ALIVE_TIMEOUT",
            .server_error => "SERVER_ERROR",
            .server_initiated_disconnect => "SERVER_INITIATED_DISCONNECT",
            .throttled => "THROTTLED",
            .websocket_ttl_expiration => "WEBSOCKET_TTL_EXPIRATION",
            .customauth_ttl_expiration => "CUSTOMAUTH_TTL_EXPIRATION",
            .unknown => "UNKNOWN",
            .none => "NONE",
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
