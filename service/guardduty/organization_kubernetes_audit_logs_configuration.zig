/// Organization-wide Kubernetes audit logs configuration.
pub const OrganizationKubernetesAuditLogsConfiguration = struct {
    /// A value that contains information on whether Kubernetes audit logs should be
    /// enabled automatically as a data source for the organization.
    auto_enable: bool,

    pub const json_field_names = .{
        .auto_enable = "AutoEnable",
    };
};
