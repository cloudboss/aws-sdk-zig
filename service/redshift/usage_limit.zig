const UsageLimitBreachAction = @import("usage_limit_breach_action.zig").UsageLimitBreachAction;
const UsageLimitFeatureType = @import("usage_limit_feature_type.zig").UsageLimitFeatureType;
const UsageLimitLimitType = @import("usage_limit_limit_type.zig").UsageLimitLimitType;
const UsageLimitPeriod = @import("usage_limit_period.zig").UsageLimitPeriod;
const Tag = @import("tag.zig").Tag;

/// Describes a usage limit object for a cluster.
pub const UsageLimit = struct {
    /// The limit amount. If time-based, this amount is in minutes. If data-based,
    /// this amount is in terabytes (TB).
    amount: ?i64 = null,

    /// The action that Amazon Redshift takes when the limit is reached. Possible
    /// values are:
    ///
    /// * **log** - To log an event in a system table. The default is log.
    ///
    /// * **emit-metric** - To emit CloudWatch metrics.
    ///
    /// * **disable** - To disable the feature until the next usage period begins.
    breach_action: ?UsageLimitBreachAction = null,

    /// The identifier of the cluster with a usage limit.
    cluster_identifier: ?[]const u8 = null,

    /// The Amazon Redshift feature to which the limit applies.
    feature_type: ?UsageLimitFeatureType = null,

    /// The type of limit. Depending on the feature type, this can be based on a
    /// time duration or data size.
    limit_type: ?UsageLimitLimitType = null,

    /// The time period that the amount applies to. A `weekly` period begins on
    /// Sunday. The default is `monthly`.
    period: ?UsageLimitPeriod = null,

    /// A list of tag instances.
    tags: ?[]const Tag = null,

    /// The identifier of the usage limit.
    usage_limit_id: ?[]const u8 = null,
};
