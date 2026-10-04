const aws = @import("aws");

const LifecyclePolicyDetailExclusionRulesAmisLastLaunched = @import("lifecycle_policy_detail_exclusion_rules_amis_last_launched.zig").LifecyclePolicyDetailExclusionRulesAmisLastLaunched;

/// Defines criteria for AMIs that are excluded from lifecycle actions.
pub const LifecyclePolicyDetailExclusionRulesAmis = struct {
    /// Configures whether public AMIs are excluded from the lifecycle action.
    is_public: bool = false,

    /// Configures Image Builder to exclude AMIs that were launched within the
    /// specified time
    /// period from lifecycle actions. AMIs with no recorded last-launched time
    /// aren't excluded by this rule.
    last_launched: ?LifecyclePolicyDetailExclusionRulesAmisLastLaunched = null,

    /// Configures Amazon Web Services Regions that are excluded from the lifecycle
    /// action.
    regions: ?[]const []const u8 = null,

    /// The lifecycle action doesn't apply to AMIs that are shared with any of
    /// the specified Amazon Web Services accounts.
    shared_accounts: ?[]const []const u8 = null,

    /// Lifecycle actions don't apply to AMIs that have any of these tags. Both
    /// the key and the value must match.
    tag_map: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .is_public = "isPublic",
        .last_launched = "lastLaunched",
        .regions = "regions",
        .shared_accounts = "sharedAccounts",
        .tag_map = "tagMap",
    };
};
