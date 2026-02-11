/// A chunk of the streamed response payload.
pub const InvokeResponseStreamUpdate = struct {
    /// Data returned by your Lambda function.
    payload: ?[]const u8,

    pub const json_field_names = .{
        .payload = "Payload",
    };
};
