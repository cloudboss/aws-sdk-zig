const OrganizationKubernetesAuditLogsConfiguration = @import("organization_kubernetes_audit_logs_configuration.zig").OrganizationKubernetesAuditLogsConfiguration;

/// Organization-wide Kubernetes data sources configurations.
pub const OrganizationKubernetesConfiguration = struct {
    /// Whether Kubernetes audit logs data source should be auto-enabled for new
    /// members joining the organization.
    audit_logs: OrganizationKubernetesAuditLogsConfiguration,

    pub const json_field_names = .{
        .audit_logs = "AuditLogs",
    };
};
