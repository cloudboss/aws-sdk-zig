const LifecyclePolicyDetailExclusionRulesAmis = @import("lifecycle_policy_detail_exclusion_rules_amis.zig").LifecyclePolicyDetailExclusionRulesAmis;

/// Additional rules to specify resources that should be exempt from ad-hoc
/// lifecycle actions.
pub const ResourceStateUpdateExclusionRules = struct {
    amis: ?LifecyclePolicyDetailExclusionRulesAmis,

    pub const json_field_names = .{
        .amis = "amis",
    };
};
