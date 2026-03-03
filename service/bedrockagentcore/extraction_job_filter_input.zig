const ExtractionJobStatus = @import("extraction_job_status.zig").ExtractionJobStatus;

/// Filters for querying memory extraction jobs based on various criteria.
pub const ExtractionJobFilterInput = struct {
    /// The identifier of the actor. If specified, only extraction jobs with this
    /// actor ID are returned.
    actor_id: ?[]const u8 = null,

    /// The unique identifier of the session. If specified, only extraction jobs
    /// with this session ID are returned.
    session_id: ?[]const u8 = null,

    /// The status of the extraction job. If specified, only extraction jobs with
    /// this status are returned.
    status: ?ExtractionJobStatus = null,

    /// The memory strategy identifier to filter extraction jobs by. If specified,
    /// only extraction jobs with this strategy ID are returned.
    strategy_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .actor_id = "actorId",
        .session_id = "sessionId",
        .status = "status",
        .strategy_id = "strategyId",
    };
};
