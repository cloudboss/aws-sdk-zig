/// A chunk of the streamed response payload.
pub const InvokeResponseStreamUpdate = struct {
    /// Data returned by your Lambda function.
    payload: ?[]const u8,
};
