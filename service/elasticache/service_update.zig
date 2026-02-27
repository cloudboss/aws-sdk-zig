const ServiceUpdateSeverity = @import("service_update_severity.zig").ServiceUpdateSeverity;
const ServiceUpdateStatus = @import("service_update_status.zig").ServiceUpdateStatus;
const ServiceUpdateType = @import("service_update_type.zig").ServiceUpdateType;

/// An update that you can apply to your Valkey or Redis OSS clusters.
pub const ServiceUpdate = struct {
    /// Indicates whether the service update will be automatically applied once the
    /// recommended apply-by date has expired.
    auto_update_after_recommended_apply_by_date: ?bool,

    /// The Elasticache engine to which the update applies. Either Valkey, Redis OSS
    /// or Memcached.
    engine: ?[]const u8,

    /// The Elasticache engine version to which the update applies. Either Valkey,
    /// Redis OSS or Memcached
    /// engine version.
    engine_version: ?[]const u8,

    /// The estimated length of time the service update will take
    estimated_update_time: ?[]const u8,

    /// Provides details of the service update
    service_update_description: ?[]const u8,

    /// The date after which the service update is no longer available
    service_update_end_date: ?i64,

    /// The unique ID of the service update
    service_update_name: ?[]const u8,

    /// The recommendend date to apply the service update in order to ensure
    /// compliance. For
    /// information on compliance, see [Self-Service Security Updates for
    /// Compliance](https://docs.aws.amazon.com/AmazonElastiCache/latest/dg/elasticache-compliance.html#elasticache-compliance-self-service).
    service_update_recommended_apply_by_date: ?i64,

    /// The date when the service update is initially available
    service_update_release_date: ?i64,

    /// The severity of the service update
    service_update_severity: ?ServiceUpdateSeverity,

    /// The status of the service update
    service_update_status: ?ServiceUpdateStatus,

    /// Reflects the nature of the service update
    service_update_type: ?ServiceUpdateType,
};
