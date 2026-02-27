const ReusableDelegationSetLimitType = @import("reusable_delegation_set_limit_type.zig").ReusableDelegationSetLimitType;

/// A complex type that contains the type of limit that you specified in the
/// request and
/// the current value for that limit.
pub const ReusableDelegationSetLimit = struct {
    /// The limit that you requested: `MAX_ZONES_BY_REUSABLE_DELEGATION_SET`, the
    /// maximum number of hosted zones that you can associate with the specified
    /// reusable
    /// delegation set.
    type: ReusableDelegationSetLimitType,

    /// The current value for the `MAX_ZONES_BY_REUSABLE_DELEGATION_SET`
    /// limit.
    value: i64,
};
