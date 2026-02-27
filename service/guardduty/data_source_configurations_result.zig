const CloudTrailConfigurationResult = @import("cloud_trail_configuration_result.zig").CloudTrailConfigurationResult;
const DNSLogsConfigurationResult = @import("dns_logs_configuration_result.zig").DNSLogsConfigurationResult;
const FlowLogsConfigurationResult = @import("flow_logs_configuration_result.zig").FlowLogsConfigurationResult;
const KubernetesConfigurationResult = @import("kubernetes_configuration_result.zig").KubernetesConfigurationResult;
const MalwareProtectionConfigurationResult = @import("malware_protection_configuration_result.zig").MalwareProtectionConfigurationResult;
const S3LogsConfigurationResult = @import("s3_logs_configuration_result.zig").S3LogsConfigurationResult;

/// Contains information on the status of data sources for the detector.
pub const DataSourceConfigurationsResult = struct {
    /// An object that contains information on the status of CloudTrail as a data
    /// source.
    cloud_trail: CloudTrailConfigurationResult,

    /// An object that contains information on the status of DNS logs as a data
    /// source.
    dns_logs: DNSLogsConfigurationResult,

    /// An object that contains information on the status of VPC flow logs as a data
    /// source.
    flow_logs: FlowLogsConfigurationResult,

    /// An object that contains information on the status of all Kubernetes data
    /// sources.
    kubernetes: ?KubernetesConfigurationResult,

    /// Describes the configuration of Malware Protection data sources.
    malware_protection: ?MalwareProtectionConfigurationResult,

    /// An object that contains information on the status of S3 Data event logs as a
    /// data
    /// source.
    s3_logs: S3LogsConfigurationResult,

    pub const json_field_names = .{
        .cloud_trail = "CloudTrail",
        .dns_logs = "DNSLogs",
        .flow_logs = "FlowLogs",
        .kubernetes = "Kubernetes",
        .malware_protection = "MalwareProtection",
        .s3_logs = "S3Logs",
    };
};
