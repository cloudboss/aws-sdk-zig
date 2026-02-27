const CollectorStatus = @import("collector_status.zig").CollectorStatus;

/// Describes the last Fleet Advisor collector health check.
pub const CollectorHealthCheck = struct {
    /// The status of the Fleet Advisor collector.
    collector_status: ?CollectorStatus,

    /// Whether the local collector can access its Amazon S3 bucket.
    local_collector_s3_access: ?bool,

    /// Whether the role that you provided when creating the Fleet Advisor collector
    /// has sufficient permissions
    /// to access the Fleet Advisor web collector.
    web_collector_granted_role_based_access: ?bool,

    /// Whether the web collector can access its Amazon S3 bucket.
    web_collector_s3_access: ?bool,

    pub const json_field_names = .{
        .collector_status = "CollectorStatus",
        .local_collector_s3_access = "LocalCollectorS3Access",
        .web_collector_granted_role_based_access = "WebCollectorGrantedRoleBasedAccess",
        .web_collector_s3_access = "WebCollectorS3Access",
    };
};
