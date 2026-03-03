const ExtractionJobMessages = @import("extraction_job_messages.zig").ExtractionJobMessages;
const ExtractionJobStatus = @import("extraction_job_status.zig").ExtractionJobStatus;

/// Metadata information associated with this extraction job.
pub const ExtractionJobMetadata = struct {
    /// The identifier of the actor for this extraction job.
    actor_id: ?[]const u8 = null,

    /// The cause of failure, if the job did not complete successfully.
    failure_reason: ?[]const u8 = null,

    /// The unique identifier for the extraction job.
    job_id: []const u8,

    /// The messages associated with the extraction job.
    messages: ExtractionJobMessages,

    /// The identifier of the session for this extraction job.
    session_id: ?[]const u8 = null,

    /// The current status of the extraction job.
    status: ?ExtractionJobStatus = null,

    /// The identifier of the memory strategy for this extraction job.
    strategy_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .actor_id = "actorId",
        .failure_reason = "failureReason",
        .job_id = "jobID",
        .messages = "messages",
        .session_id = "sessionId",
        .status = "status",
        .strategy_id = "strategyId",
    };
};
