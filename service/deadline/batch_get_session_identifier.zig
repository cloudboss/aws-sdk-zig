/// The identifiers for a session.
pub const BatchGetSessionIdentifier = struct {
    /// The farm ID of the session.
    farm_id: []const u8,

    /// The job ID of the session.
    job_id: []const u8,

    /// The queue ID of the session.
    queue_id: []const u8,

    /// The session ID.
    session_id: []const u8,

    pub const json_field_names = .{
        .farm_id = "farmId",
        .job_id = "jobId",
        .queue_id = "queueId",
        .session_id = "sessionId",
    };
};
