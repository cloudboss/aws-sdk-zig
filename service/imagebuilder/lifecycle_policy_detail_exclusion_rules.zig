const aws = @import("aws");

const LifecyclePolicyDetailExclusionRulesAmis = @import("lifecycle_policy_detail_exclusion_rules_amis.zig").LifecyclePolicyDetailExclusionRulesAmis;

/// Specifies resources that lifecycle policy actions should not apply to.
pub const LifecyclePolicyDetailExclusionRules = struct {
    /// Lists configuration values that apply to AMIs that Image Builder should
    /// exclude
    /// from the lifecycle action.
    amis: ?LifecyclePolicyDetailExclusionRulesAmis = null,

    /// Contains a list of tags that Image Builder uses to skip lifecycle actions
    /// for Image Builder image
    /// resources that have them.
    tag_map: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .amis = "amis",
        .tag_map = "tagMap",
    };
};
