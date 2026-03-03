/// Specifies the error message that is returned if the operation cannot be
/// successfully completed.
pub const FailureCause = struct {
    /// The description of the error message.
    message: ?[]const u8 = null,

    pub const json_field_names = .{
        .message = "message",
    };
};
