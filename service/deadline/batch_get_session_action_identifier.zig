/// The identifiers for a session action.
pub const BatchGetSessionActionIdentifier = struct {
    /// The farm ID of the session action.
    farm_id: []const u8,

    /// The job ID of the session action.
    job_id: []const u8,

    /// The queue ID of the session action.
    queue_id: []const u8,

    /// The session action ID.
    session_action_id: []const u8,

    pub const json_field_names = .{
        .farm_id = "farmId",
        .job_id = "jobId",
        .queue_id = "queueId",
        .session_action_id = "sessionActionId",
    };
};
