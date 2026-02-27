const OrganizationKubernetesConfigurationResult = @import("organization_kubernetes_configuration_result.zig").OrganizationKubernetesConfigurationResult;
const OrganizationMalwareProtectionConfigurationResult = @import("organization_malware_protection_configuration_result.zig").OrganizationMalwareProtectionConfigurationResult;
const OrganizationS3LogsConfigurationResult = @import("organization_s3_logs_configuration_result.zig").OrganizationS3LogsConfigurationResult;

/// An object that contains information on which data sources are automatically
/// enabled for
/// new members within the organization.
pub const OrganizationDataSourceConfigurationsResult = struct {
    /// Describes the configuration of Kubernetes data sources.
    kubernetes: ?OrganizationKubernetesConfigurationResult,

    /// Describes the configuration of Malware Protection data source for an
    /// organization.
    malware_protection: ?OrganizationMalwareProtectionConfigurationResult,

    /// Describes whether S3 data event logs are enabled as a data source.
    s3_logs: OrganizationS3LogsConfigurationResult,

    pub const json_field_names = .{
        .kubernetes = "Kubernetes",
        .malware_protection = "MalwareProtection",
        .s3_logs = "S3Logs",
    };
};
