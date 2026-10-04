const ResourceQuota = @import("resource_quota.zig").ResourceQuota;

/// A set of per-resource Elastic Beanstalk quotas associated with an Amazon Web
/// Services account. They reflect
/// Elastic Beanstalk resource limits for this account.
pub const ResourceQuotas = struct {
    /// The quota for applications in the Amazon Web Services account.
    application_quota: ?ResourceQuota = null,

    /// The quota for application versions in the Amazon Web Services account.
    application_version_quota: ?ResourceQuota = null,

    /// The quota for configuration templates in the Amazon Web Services account.
    configuration_template_quota: ?ResourceQuota = null,

    /// The quota for custom platforms in the Amazon Web Services account.
    custom_platform_quota: ?ResourceQuota = null,

    /// The quota for environments in the Amazon Web Services account.
    environment_quota: ?ResourceQuota = null,
};
