const KubernetesAuditLogsConfigurationResult = @import("kubernetes_audit_logs_configuration_result.zig").KubernetesAuditLogsConfigurationResult;

/// Describes whether any Kubernetes logs will be enabled as a data source.
pub const KubernetesConfigurationResult = struct {
    /// Describes whether Kubernetes audit logs are enabled as a data source.
    audit_logs: KubernetesAuditLogsConfigurationResult,

    pub const json_field_names = .{
        .audit_logs = "AuditLogs",
    };
};
