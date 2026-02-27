pub const MatchmakingConfigurationStatus = enum {
    cancelled,
    completed,
    failed,
    placing,
    queued,
    requires_acceptance,
    searching,
    timed_out,

    pub const json_field_names = .{
        .cancelled = "CANCELLED",
        .completed = "COMPLETED",
        .failed = "FAILED",
        .placing = "PLACING",
        .queued = "QUEUED",
        .requires_acceptance = "REQUIRES_ACCEPTANCE",
        .searching = "SEARCHING",
        .timed_out = "TIMED_OUT",
    };
};
