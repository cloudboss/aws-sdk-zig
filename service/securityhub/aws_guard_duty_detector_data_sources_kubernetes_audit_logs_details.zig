/// An object that contains information on the status of Kubernetes audit logs
/// as a data source for the detector.
pub const AwsGuardDutyDetectorDataSourcesKubernetesAuditLogsDetails = struct {
    /// Describes whether Kubernetes audit logs are activated as a data source for
    /// the detector.
    status: ?[]const u8,

    pub const json_field_names = .{
        .status = "Status",
    };
};
