/// The reason for a partial failure of an AutoML job.
pub const AutoMLPartialFailureReason = struct {
    /// The message containing the reason for a partial failure of an AutoML job.
    partial_failure_message: ?[]const u8 = null,

    pub const json_field_names = .{
        .partial_failure_message = "PartialFailureMessage",
    };
};
