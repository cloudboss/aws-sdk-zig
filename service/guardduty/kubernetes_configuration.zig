const KubernetesAuditLogsConfiguration = @import("kubernetes_audit_logs_configuration.zig").KubernetesAuditLogsConfiguration;

/// Describes whether any Kubernetes data sources are enabled.
pub const KubernetesConfiguration = struct {
    /// The status of Kubernetes audit logs as a data source.
    audit_logs: KubernetesAuditLogsConfiguration,

    pub const json_field_names = .{
        .audit_logs = "AuditLogs",
    };
};
