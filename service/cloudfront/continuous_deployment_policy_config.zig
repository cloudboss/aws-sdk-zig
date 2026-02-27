const StagingDistributionDnsNames = @import("staging_distribution_dns_names.zig").StagingDistributionDnsNames;
const TrafficConfig = @import("traffic_config.zig").TrafficConfig;

/// Contains the configuration for a continuous deployment policy.
pub const ContinuousDeploymentPolicyConfig = struct {
    /// A Boolean that indicates whether this continuous deployment policy is
    /// enabled (in effect). When this value is `true`, this policy is enabled and
    /// in effect. When this value is `false`, this policy is not enabled and has no
    /// effect.
    enabled: bool,

    /// The CloudFront domain name of the staging distribution. For example:
    /// `d111111abcdef8.cloudfront.net`.
    staging_distribution_dns_names: StagingDistributionDnsNames,

    /// Contains the parameters for routing production traffic from your primary to
    /// staging distributions.
    traffic_config: ?TrafficConfig,
};
