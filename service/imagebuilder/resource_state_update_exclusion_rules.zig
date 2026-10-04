const LifecyclePolicyDetailExclusionRulesAmis = @import("lifecycle_policy_detail_exclusion_rules_amis.zig").LifecyclePolicyDetailExclusionRulesAmis;

/// Additional rules to specify resources that should be exempt from ad-hoc
/// lifecycle actions.
pub const ResourceStateUpdateExclusionRules = struct {
    /// Defines criteria for AMIs that Image Builder should exclude from the
    /// resource
    /// state update.
    amis: ?LifecyclePolicyDetailExclusionRulesAmis = null,

    pub const json_field_names = .{
        .amis = "amis",
    };
};
