/// Specifies how to handle response payload content type conversions. Supported
/// only for WebSocket APIs.
pub const ContentHandlingStrategy = enum {
    convert_to_binary,
    convert_to_text,

    pub const json_field_names = .{
        .convert_to_binary = "CONVERT_TO_BINARY",
        .convert_to_text = "CONVERT_TO_TEXT",
    };
};
