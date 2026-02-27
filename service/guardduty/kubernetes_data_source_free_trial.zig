const DataSourceFreeTrial = @import("data_source_free_trial.zig").DataSourceFreeTrial;

/// Provides details about the Kubernetes resources when it is enabled as a data
/// source.
pub const KubernetesDataSourceFreeTrial = struct {
    /// Describes whether Kubernetes audit logs are enabled as a data source.
    audit_logs: ?DataSourceFreeTrial,

    pub const json_field_names = .{
        .audit_logs = "AuditLogs",
    };
};
