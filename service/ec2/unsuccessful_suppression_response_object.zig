/// Describes an unsuccessful application status check suppression.
pub const UnsuccessfulSuppressionResponseObject = struct {
    /// The ID of the instance.
    instance_id: ?[]const u8 = null,

    /// The reason the suppression failed.
    reason: ?[]const u8 = null,

    /// The date and time when health checks would have resumed.
    resume_at: ?i64 = null,

    /// The date and time when suppression was attempted.
    suppress_at: ?i64 = null,
};
