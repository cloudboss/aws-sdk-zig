/// The failure reason, if any, for a create or delete endpoint operation.
pub const FailedReason = struct {
    /// The failure code, if any, for a create or delete endpoint operation.
    error_code: ?[]const u8 = null,

    /// Additional error details describing the endpoint failure and recommended
    /// action.
    message: ?[]const u8 = null,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
        .message = "Message",
    };
};
