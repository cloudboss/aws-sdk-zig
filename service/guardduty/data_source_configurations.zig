const KubernetesConfiguration = @import("kubernetes_configuration.zig").KubernetesConfiguration;
const MalwareProtectionConfiguration = @import("malware_protection_configuration.zig").MalwareProtectionConfiguration;
const S3LogsConfiguration = @import("s3_logs_configuration.zig").S3LogsConfiguration;

/// Contains information about which data sources are enabled.
pub const DataSourceConfigurations = struct {
    /// Describes whether any Kubernetes logs are enabled as data sources.
    kubernetes: ?KubernetesConfiguration,

    /// Describes whether Malware Protection is enabled as a data source.
    malware_protection: ?MalwareProtectionConfiguration,

    /// Describes whether S3 data event logs are enabled as a data source.
    s3_logs: ?S3LogsConfiguration,

    pub const json_field_names = .{
        .kubernetes = "Kubernetes",
        .malware_protection = "MalwareProtection",
        .s3_logs = "S3Logs",
    };
};
