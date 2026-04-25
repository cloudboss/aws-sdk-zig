/// The current configuration of Kubernetes audit logs as a data source for the
/// organization.
pub const OrganizationKubernetesAuditLogsConfigurationResult = struct {
    /// Whether Kubernetes audit logs data source should be auto-enabled for new
    /// members joining the organization.
    auto_enable: bool,

    pub const json_field_names = .{
        .auto_enable = "AutoEnable",
    };
};
