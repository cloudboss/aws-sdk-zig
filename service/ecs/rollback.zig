/// Information about the service deployment rollback.
pub const Rollback = struct {
    /// The reason the rollback happened. For example, the circuit breaker initiated
    /// the
    /// rollback operation.
    reason: ?[]const u8,

    /// The ARN of the service revision deployed as part of the rollback.
    service_revision_arn: ?[]const u8,

    /// Time time that the rollback started. The format is yyyy-MM-dd
    /// HH:mm:ss.SSSSSS.
    started_at: ?i64,

    pub const json_field_names = .{
        .reason = "reason",
        .service_revision_arn = "serviceRevisionArn",
        .started_at = "startedAt",
    };
};
