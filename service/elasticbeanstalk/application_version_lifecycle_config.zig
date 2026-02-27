const MaxAgeRule = @import("max_age_rule.zig").MaxAgeRule;
const MaxCountRule = @import("max_count_rule.zig").MaxCountRule;

/// The application version lifecycle settings for an application. Defines the
/// rules that
/// Elastic Beanstalk applies to an application's versions in order to avoid
/// hitting the
/// per-region limit for application versions.
///
/// When Elastic Beanstalk deletes an application version from its database, you
/// can no
/// longer deploy that version to an environment. The source bundle remains in
/// S3 unless you
/// configure the rule to delete it.
pub const ApplicationVersionLifecycleConfig = struct {
    /// Specify a max age rule to restrict the length of time that application
    /// versions are
    /// retained for an application.
    max_age_rule: ?MaxAgeRule,

    /// Specify a max count rule to restrict the number of application versions that
    /// are
    /// retained for an application.
    max_count_rule: ?MaxCountRule,
};
