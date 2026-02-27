const OrganizationKubernetesConfiguration = @import("organization_kubernetes_configuration.zig").OrganizationKubernetesConfiguration;
const OrganizationMalwareProtectionConfiguration = @import("organization_malware_protection_configuration.zig").OrganizationMalwareProtectionConfiguration;
const OrganizationS3LogsConfiguration = @import("organization_s3_logs_configuration.zig").OrganizationS3LogsConfiguration;

/// An object that contains information on which data sources will be configured
/// to be
/// automatically enabled for new members within the organization.
pub const OrganizationDataSourceConfigurations = struct {
    /// Describes the configuration of Kubernetes data sources for new members of
    /// the
    /// organization.
    kubernetes: ?OrganizationKubernetesConfiguration,

    /// Describes the configuration of Malware Protection for new members of the
    /// organization.
    malware_protection: ?OrganizationMalwareProtectionConfiguration,

    /// Describes whether S3 data event logs are enabled for new members of the
    /// organization.
    s3_logs: ?OrganizationS3LogsConfiguration,

    pub const json_field_names = .{
        .kubernetes = "Kubernetes",
        .malware_protection = "MalwareProtection",
        .s3_logs = "S3Logs",
    };
};
