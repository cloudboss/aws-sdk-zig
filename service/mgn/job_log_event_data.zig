/// Job log data
pub const JobLogEventData = struct {
    /// Retries for this operation.
    attempt_count: ?i32 = null,

    /// Job Event conversion Server ID.
    conversion_server_id: ?[]const u8 = null,

    /// The maximum number of retries that will be attempted if this operation
    /// failed.
    max_attempts_count: ?i32 = null,

    /// Job error.
    raw_error: ?[]const u8 = null,

    /// Job Event Source Server ID.
    source_server_id: ?[]const u8 = null,

    /// Job Event Target instance ID.
    target_instance_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .attempt_count = "attemptCount",
        .conversion_server_id = "conversionServerID",
        .max_attempts_count = "maxAttemptsCount",
        .raw_error = "rawError",
        .source_server_id = "sourceServerID",
        .target_instance_id = "targetInstanceID",
    };
};
