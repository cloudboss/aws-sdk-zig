const DataSourceFreeTrial = @import("data_source_free_trial.zig").DataSourceFreeTrial;
const KubernetesDataSourceFreeTrial = @import("kubernetes_data_source_free_trial.zig").KubernetesDataSourceFreeTrial;
const MalwareProtectionDataSourceFreeTrial = @import("malware_protection_data_source_free_trial.zig").MalwareProtectionDataSourceFreeTrial;

/// Contains information about which data sources are enabled for the GuardDuty
/// member account.
pub const DataSourcesFreeTrial = struct {
    /// Describes whether any Amazon Web Services CloudTrail management event logs
    /// are enabled as data sources.
    cloud_trail: ?DataSourceFreeTrial = null,

    /// Describes whether any DNS logs are enabled as data sources.
    dns_logs: ?DataSourceFreeTrial = null,

    /// Describes whether any VPC Flow logs are enabled as data sources.
    flow_logs: ?DataSourceFreeTrial = null,

    /// Describes whether any Kubernetes logs are enabled as data sources.
    kubernetes: ?KubernetesDataSourceFreeTrial = null,

    /// Describes whether Malware Protection is enabled as a data source.
    malware_protection: ?MalwareProtectionDataSourceFreeTrial = null,

    /// Describes whether any S3 data event logs are enabled as data sources.
    s3_logs: ?DataSourceFreeTrial = null,

    pub const json_field_names = .{
        .cloud_trail = "CloudTrail",
        .dns_logs = "DnsLogs",
        .flow_logs = "FlowLogs",
        .kubernetes = "Kubernetes",
        .malware_protection = "MalwareProtection",
        .s3_logs = "S3Logs",
    };
};
