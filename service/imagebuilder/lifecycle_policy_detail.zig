const LifecyclePolicyDetailAction = @import("lifecycle_policy_detail_action.zig").LifecyclePolicyDetailAction;
const LifecyclePolicyDetailExclusionRules = @import("lifecycle_policy_detail_exclusion_rules.zig").LifecyclePolicyDetailExclusionRules;
const LifecyclePolicyDetailFilter = @import("lifecycle_policy_detail_filter.zig").LifecyclePolicyDetailFilter;

/// The configuration details for a lifecycle policy resource.
pub const LifecyclePolicyDetail = struct {
    /// Configuration details for the policy action.
    action: LifecyclePolicyDetailAction,

    /// Additional rules to specify resources that should be exempt from policy
    /// actions.
    exclusion_rules: ?LifecyclePolicyDetailExclusionRules = null,

    /// Specifies the resources that the lifecycle policy applies to.
    filter: LifecyclePolicyDetailFilter,

    pub const json_field_names = .{
        .action = "action",
        .exclusion_rules = "exclusionRules",
        .filter = "filter",
    };
};
