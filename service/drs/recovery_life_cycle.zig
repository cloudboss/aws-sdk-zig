const RecoveryResult = @import("recovery_result.zig").RecoveryResult;

/// An object representing the Source Network recovery Lifecycle.
pub const RecoveryLifeCycle = struct {
    /// The date and time the last Source Network recovery was initiated.
    api_call_date_time: ?i64,

    /// The ID of the Job that was used to last recover the Source Network.
    job_id: ?[]const u8,

    /// The status of the last recovery status of this Source Network.
    last_recovery_result: ?RecoveryResult,

    pub const json_field_names = .{
        .api_call_date_time = "apiCallDateTime",
        .job_id = "jobID",
        .last_recovery_result = "lastRecoveryResult",
    };
};
