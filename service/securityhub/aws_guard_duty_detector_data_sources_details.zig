const AwsGuardDutyDetectorDataSourcesCloudTrailDetails = @import("aws_guard_duty_detector_data_sources_cloud_trail_details.zig").AwsGuardDutyDetectorDataSourcesCloudTrailDetails;
const AwsGuardDutyDetectorDataSourcesDnsLogsDetails = @import("aws_guard_duty_detector_data_sources_dns_logs_details.zig").AwsGuardDutyDetectorDataSourcesDnsLogsDetails;
const AwsGuardDutyDetectorDataSourcesFlowLogsDetails = @import("aws_guard_duty_detector_data_sources_flow_logs_details.zig").AwsGuardDutyDetectorDataSourcesFlowLogsDetails;
const AwsGuardDutyDetectorDataSourcesKubernetesDetails = @import("aws_guard_duty_detector_data_sources_kubernetes_details.zig").AwsGuardDutyDetectorDataSourcesKubernetesDetails;
const AwsGuardDutyDetectorDataSourcesMalwareProtectionDetails = @import("aws_guard_duty_detector_data_sources_malware_protection_details.zig").AwsGuardDutyDetectorDataSourcesMalwareProtectionDetails;
const AwsGuardDutyDetectorDataSourcesS3LogsDetails = @import("aws_guard_duty_detector_data_sources_s3_logs_details.zig").AwsGuardDutyDetectorDataSourcesS3LogsDetails;

/// Describes which data sources are activated for the detector.
pub const AwsGuardDutyDetectorDataSourcesDetails = struct {
    /// An object that contains information on the status of CloudTrail as a data
    /// source for the detector.
    cloud_trail: ?AwsGuardDutyDetectorDataSourcesCloudTrailDetails = null,

    /// An object that contains information on the status of DNS logs as a data
    /// source for the detector.
    dns_logs: ?AwsGuardDutyDetectorDataSourcesDnsLogsDetails = null,

    /// An object that contains information on the status of VPC Flow Logs as a data
    /// source for the detector.
    flow_logs: ?AwsGuardDutyDetectorDataSourcesFlowLogsDetails = null,

    /// An object that contains information on the status of Kubernetes data sources
    /// for the detector.
    kubernetes: ?AwsGuardDutyDetectorDataSourcesKubernetesDetails = null,

    /// An object that contains information on the status of Malware Protection as a
    /// data source for the detector.
    malware_protection: ?AwsGuardDutyDetectorDataSourcesMalwareProtectionDetails = null,

    /// An object that contains information on the status of S3 Data event logs as a
    /// data source for the detector.
    s3_logs: ?AwsGuardDutyDetectorDataSourcesS3LogsDetails = null,

    pub const json_field_names = .{
        .cloud_trail = "CloudTrail",
        .dns_logs = "DnsLogs",
        .flow_logs = "FlowLogs",
        .kubernetes = "Kubernetes",
        .malware_protection = "MalwareProtection",
        .s3_logs = "S3Logs",
    };
};
