/// The request was denied due to an invalid request error.
pub const ValidationExceptionField = struct {
    /// The request was denied due to an invalid request error.
    message: []const u8,

    /// The request was denied due to an invalid request error.
    path: []const u8,

    pub const json_field_names = .{
        .message = "message",
        .path = "path",
    };
};
