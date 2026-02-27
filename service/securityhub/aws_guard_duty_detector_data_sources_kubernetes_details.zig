const AwsGuardDutyDetectorDataSourcesKubernetesAuditLogsDetails = @import("aws_guard_duty_detector_data_sources_kubernetes_audit_logs_details.zig").AwsGuardDutyDetectorDataSourcesKubernetesAuditLogsDetails;

/// An object that contains information on the status of Kubernetes data sources
/// for the detector.
pub const AwsGuardDutyDetectorDataSourcesKubernetesDetails = struct {
    /// Describes whether Kubernetes audit logs are activated as a data source for
    /// the detector.
    audit_logs: ?AwsGuardDutyDetectorDataSourcesKubernetesAuditLogsDetails,

    pub const json_field_names = .{
        .audit_logs = "AuditLogs",
    };
};
