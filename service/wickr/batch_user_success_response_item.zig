/// Contains information about a user that was successfully processed in a batch
/// user operation.
pub const BatchUserSuccessResponseItem = struct {
    /// The user ID that was successfully processed.
    user_id: []const u8,

    pub const json_field_names = .{
        .user_id = "userId",
    };
};
