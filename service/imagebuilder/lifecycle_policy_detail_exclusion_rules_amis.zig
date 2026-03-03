const aws = @import("aws");

const LifecyclePolicyDetailExclusionRulesAmisLastLaunched = @import("lifecycle_policy_detail_exclusion_rules_amis_last_launched.zig").LifecyclePolicyDetailExclusionRulesAmisLastLaunched;

/// Defines criteria for AMIs that are excluded from lifecycle actions.
pub const LifecyclePolicyDetailExclusionRulesAmis = struct {
    /// Configures whether public AMIs are excluded from the lifecycle action.
    is_public: bool = false,

    /// Specifies configuration details for Image Builder to exclude the most recent
    /// resources
    /// from lifecycle actions.
    last_launched: ?LifecyclePolicyDetailExclusionRulesAmisLastLaunched = null,

    /// Configures Amazon Web Services Regions that are excluded from the lifecycle
    /// action.
    regions: ?[]const []const u8 = null,

    /// Specifies Amazon Web Services accounts whose resources are excluded from the
    /// lifecycle action.
    shared_accounts: ?[]const []const u8 = null,

    /// Lists tags that should be excluded from lifecycle actions for the AMIs that
    /// have them.
    tag_map: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .is_public = "isPublic",
        .last_launched = "lastLaunched",
        .regions = "regions",
        .shared_accounts = "sharedAccounts",
        .tag_map = "tagMap",
    };
};
