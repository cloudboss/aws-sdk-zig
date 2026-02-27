/// State of a campaign
pub const CampaignState = enum {
    /// Campaign is in initialized state
    initialized,
    /// Campaign is in running state
    running,
    /// Campaign is in paused state
    paused,
    /// Campaign is in stopped state
    stopped,
    /// Campaign is in failed state
    failed,

    pub const json_field_names = .{
        .initialized = "INITIALIZED",
        .running = "RUNNING",
        .paused = "PAUSED",
        .stopped = "STOPPED",
        .failed = "FAILED",
    };
};
