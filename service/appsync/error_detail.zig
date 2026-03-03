/// Contains the list of errors generated. When using JavaScript, this will
/// apply to the
/// request or response function evaluation.
pub const ErrorDetail = struct {
    /// The error payload.
    message: ?[]const u8 = null,

    pub const json_field_names = .{
        .message = "message",
    };
};
