const AccountLimitType = @import("account_limit_type.zig").AccountLimitType;

/// A complex type that contains the type of limit that you specified in the
/// request and
/// the current value for that limit.
pub const AccountLimit = struct {
    /// The limit that you requested. Valid values include the following:
    ///
    /// * **MAX_HEALTH_CHECKS_BY_OWNER**: The maximum
    /// number of health checks that you can create using the current account.
    ///
    /// * **MAX_HOSTED_ZONES_BY_OWNER**: The maximum number
    /// of hosted zones that you can create using the current account.
    ///
    /// * **MAX_REUSABLE_DELEGATION_SETS_BY_OWNER**: The
    /// maximum number of reusable delegation sets that you can create using the
    /// current
    /// account.
    ///
    /// * **MAX_TRAFFIC_POLICIES_BY_OWNER**: The maximum
    /// number of traffic policies that you can create using the current account.
    ///
    /// * **MAX_TRAFFIC_POLICY_INSTANCES_BY_OWNER**: The
    /// maximum number of traffic policy instances that you can create using the
    /// current
    /// account. (Traffic policy instances are referred to as traffic flow policy
    /// records in the Amazon Route 53 console.)
    type: AccountLimitType,

    /// The current value for the limit that is specified by
    /// [Type](https://docs.aws.amazon.com/Route53/latest/APIReference/API_AccountLimit.html#Route53-Type-AccountLimit-Type).
    value: i64,
};
