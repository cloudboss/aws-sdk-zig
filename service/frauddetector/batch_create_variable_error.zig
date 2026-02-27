/// Provides the error of the batch create variable API.
pub const BatchCreateVariableError = struct {
    /// The error code.
    code: i32 = 0,

    /// The error message.
    message: ?[]const u8,

    /// The name.
    name: ?[]const u8,

    pub const json_field_names = .{
        .code = "code",
        .message = "message",
        .name = "name",
    };
};
