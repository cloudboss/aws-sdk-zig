const ApplicationHealthStatus = @import("application_health_status.zig").ApplicationHealthStatus;
const ApplicationProgressStatus = @import("application_progress_status.zig").ApplicationProgressStatus;

/// Application aggregated status.
pub const ApplicationAggregatedStatus = struct {
    /// Application aggregated status health status.
    health_status: ?ApplicationHealthStatus = null,

    /// Application aggregated status last update dateTime.
    last_update_date_time: ?[]const u8 = null,

    /// Application aggregated status progress status.
    progress_status: ?ApplicationProgressStatus = null,

    /// Application aggregated status total source servers amount.
    total_source_servers: i64 = 0,

    pub const json_field_names = .{
        .health_status = "healthStatus",
        .last_update_date_time = "lastUpdateDateTime",
        .progress_status = "progressStatus",
        .total_source_servers = "totalSourceServers",
    };
};
