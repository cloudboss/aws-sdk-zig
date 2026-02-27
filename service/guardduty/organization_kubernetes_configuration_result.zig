const OrganizationKubernetesAuditLogsConfigurationResult = @import("organization_kubernetes_audit_logs_configuration_result.zig").OrganizationKubernetesAuditLogsConfigurationResult;

/// The current configuration of all Kubernetes data sources for the
/// organization.
pub const OrganizationKubernetesConfigurationResult = struct {
    /// The current configuration of Kubernetes audit logs as a data source for the
    /// organization.
    audit_logs: OrganizationKubernetesAuditLogsConfigurationResult,

    pub const json_field_names = .{
        .audit_logs = "AuditLogs",
    };
};
