const DataSourceStatus = @import("data_source_status.zig").DataSourceStatus;

/// Describes whether Kubernetes audit logs are enabled as a data source.
pub const KubernetesAuditLogsConfigurationResult = struct {
    /// A value that describes whether Kubernetes audit logs are enabled as a data
    /// source.
    status: DataSourceStatus,

    pub const json_field_names = .{
        .status = "Status",
    };
};
