/// Describes a successful application status check suppression.
pub const SuccessfulSuppressionResponseObject = struct {
    /// The ID of the instance.
    instance_id: ?[]const u8 = null,

    /// The date and time when suppression ends and health checks resume.
    resume_at: ?i64 = null,

    /// The date and time when suppression started.
    suppress_at: ?i64 = null,
};
