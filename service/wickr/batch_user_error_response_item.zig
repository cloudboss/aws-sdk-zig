/// Contains error information for a user operation that failed in a batch user
/// request.
pub const BatchUserErrorResponseItem = struct {
    /// The field that caused the error.
    field: ?[]const u8,

    /// A description of why the user operation failed.
    reason: ?[]const u8,

    /// The user ID associated with the failed operation.
    user_id: []const u8,

    pub const json_field_names = .{
        .field = "field",
        .reason = "reason",
        .user_id = "userId",
    };
};
