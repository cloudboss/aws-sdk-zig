/// Represents a protocol type.
pub const ProtocolType = enum {
    websocket,
    http,

    pub const json_field_names = .{
        .websocket = "WEBSOCKET",
        .http = "HTTP",
    };
};
