const LifecyclePolicyDetailFilterType = @import("lifecycle_policy_detail_filter_type.zig").LifecyclePolicyDetailFilterType;
const LifecyclePolicyTimeUnit = @import("lifecycle_policy_time_unit.zig").LifecyclePolicyTimeUnit;

/// Defines filters that the lifecycle policy uses to determine impacted
/// resource.
pub const LifecyclePolicyDetailFilter = struct {
    /// For age-based filters, this is the number of resources to keep on hand after
    /// the lifecycle
    /// `DELETE` action is applied. Impacted resources are only deleted if you have
    /// more than
    /// this number of resources. If you have fewer resources than this number, the
    /// impacted resource
    /// is not deleted.
    retain_at_least: ?i32,

    /// Filter resources based on either `age` or `count`.
    type: LifecyclePolicyDetailFilterType,

    /// Defines the unit of time that the lifecycle policy uses to determine
    /// impacted
    /// resources. This is required for age-based rules.
    unit: ?LifecyclePolicyTimeUnit,

    /// The number of units for the time period or for the count. For example, a
    /// value of
    /// `6` might refer to six months or six AMIs.
    ///
    /// For count-based filters, this value represents the minimum number of
    /// resources
    /// to keep on hand. If you have fewer resources than this number, the resource
    /// is
    /// excluded from lifecycle actions.
    value: i32,

    pub const json_field_names = .{
        .retain_at_least = "retainAtLeast",
        .type = "type",
        .unit = "unit",
        .value = "value",
    };
};
