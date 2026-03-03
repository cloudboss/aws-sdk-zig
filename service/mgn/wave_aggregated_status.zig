const WaveHealthStatus = @import("wave_health_status.zig").WaveHealthStatus;
const WaveProgressStatus = @import("wave_progress_status.zig").WaveProgressStatus;

/// Wave aggregated status.
pub const WaveAggregatedStatus = struct {
    /// Wave aggregated status health status.
    health_status: ?WaveHealthStatus = null,

    /// Wave aggregated status last update dateTime.
    last_update_date_time: ?[]const u8 = null,

    /// Wave aggregated status progress status.
    progress_status: ?WaveProgressStatus = null,

    /// DateTime marking when the first source server in the wave started
    /// replication.
    replication_started_date_time: ?[]const u8 = null,

    /// Wave aggregated status total applications amount.
    total_applications: i64 = 0,

    pub const json_field_names = .{
        .health_status = "healthStatus",
        .last_update_date_time = "lastUpdateDateTime",
        .progress_status = "progressStatus",
        .replication_started_date_time = "replicationStartedDateTime",
        .total_applications = "totalApplications",
    };
};
