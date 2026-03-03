const IpRuleItem = @import("ip_rule_item.zig").IpRuleItem;

/// Describes an IP access control group.
pub const WorkspacesIpGroup = struct {
    /// The description of the group.
    group_desc: ?[]const u8 = null,

    /// The identifier of the group.
    group_id: ?[]const u8 = null,

    /// The name of the group.
    group_name: ?[]const u8 = null,

    /// The rules.
    user_rules: ?[]const IpRuleItem = null,

    pub const json_field_names = .{
        .group_desc = "groupDesc",
        .group_id = "groupId",
        .group_name = "groupName",
        .user_rules = "userRules",
    };
};
