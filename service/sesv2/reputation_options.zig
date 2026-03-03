/// Enable or disable collection of reputation metrics for emails that you send
/// using this
/// configuration set in the current Amazon Web Services Region.
pub const ReputationOptions = struct {
    /// The date and time (in Unix time) when the reputation metrics were last given
    /// a fresh
    /// start. When your account is given a fresh start, your reputation metrics are
    /// calculated
    /// starting from the date of the fresh start.
    last_fresh_start: ?i64 = null,

    /// If `true`, tracking of reputation metrics is enabled for the configuration
    /// set. If `false`, tracking of reputation metrics is disabled for the
    /// configuration set.
    reputation_metrics_enabled: bool = false,

    pub const json_field_names = .{
        .last_fresh_start = "LastFreshStart",
        .reputation_metrics_enabled = "ReputationMetricsEnabled",
    };
};
