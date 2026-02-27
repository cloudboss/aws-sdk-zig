const AggregatedProfileTime = @import("aggregated_profile_time.zig").AggregatedProfileTime;

/// Profiling status includes information about the last time a profile agent
/// pinged back,
/// the last time a profile was received, and the aggregation period and start
/// time for the
/// most recent aggregated profile.
pub const ProfilingStatus = struct {
    /// The date and time when the profiling agent most recently pinged back.
    /// Specify using
    /// the ISO 8601 format. For example,
    /// 2020-06-01T13:15:02.001Z represents 1 millisecond past June 1, 2020 1:15:02
    /// PM UTC.
    latest_agent_orchestrated_at: ?i64,

    /// The date and time when the most recent profile was received. Specify using
    /// the ISO 8601 format. For example,
    /// 2020-06-01T13:15:02.001Z represents 1 millisecond past June 1, 2020 1:15:02
    /// PM UTC.
    latest_agent_profile_reported_at: ?i64,

    /// An [
    /// `AggregatedProfileTime`
    /// ](https://docs.aws.amazon.com/codeguru/latest/profiler-api/API_AggregatedProfileTime.html)
    /// object that contains the aggregation period and start time for an aggregated
    /// profile.
    latest_aggregated_profile: ?AggregatedProfileTime,

    pub const json_field_names = .{
        .latest_agent_orchestrated_at = "latestAgentOrchestratedAt",
        .latest_agent_profile_reported_at = "latestAgentProfileReportedAt",
        .latest_aggregated_profile = "latestAggregatedProfile",
    };
};
