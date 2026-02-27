pub const ConnectionType = enum {
    websocket,
    connection_credentials,
    webrtc_connection,

    pub const json_field_names = .{
        .websocket = "WEBSOCKET",
        .connection_credentials = "CONNECTION_CREDENTIALS",
        .webrtc_connection = "WEBRTC_CONNECTION",
    };
};
