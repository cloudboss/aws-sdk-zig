const ResourceQuota = @import("resource_quota.zig").ResourceQuota;

/// A set of per-resource AWS Elastic Beanstalk quotas associated with an AWS
/// account. They reflect
/// Elastic Beanstalk resource limits for this account.
pub const ResourceQuotas = struct {
    /// The quota for applications in the AWS account.
    application_quota: ?ResourceQuota,

    /// The quota for application versions in the AWS account.
    application_version_quota: ?ResourceQuota,

    /// The quota for configuration templates in the AWS account.
    configuration_template_quota: ?ResourceQuota,

    /// The quota for custom platforms in the AWS account.
    custom_platform_quota: ?ResourceQuota,

    /// The quota for environments in the AWS account.
    environment_quota: ?ResourceQuota,
};
