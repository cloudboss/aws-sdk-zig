/// Represents a target that failed to be added to a rule.
pub const PutTargetsResultEntry = struct {
    /// The error code that indicates why the target addition failed. If the value
    /// is
    /// `ConcurrentModificationException`, too many requests were made at the same
    /// time.
    error_code: ?[]const u8 = null,

    /// The error message that explains why the target addition failed.
    error_message: ?[]const u8 = null,

    /// The ID of the target.
    target_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
        .error_message = "ErrorMessage",
        .target_id = "TargetId",
    };
};
