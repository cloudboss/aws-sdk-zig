/// Describes whether Kubernetes audit logs are enabled as a data source.
pub const KubernetesAuditLogsConfiguration = struct {
    /// The status of Kubernetes audit logs as a data source.
    enable: bool,

    pub const json_field_names = .{
        .enable = "Enable",
    };
};
