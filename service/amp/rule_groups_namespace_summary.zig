const aws = @import("aws");

const RuleGroupsNamespaceStatus = @import("rule_groups_namespace_status.zig").RuleGroupsNamespaceStatus;

/// The high-level information about a rule groups namespace. To retrieve more
/// information, use `DescribeRuleGroupsNamespace`.
pub const RuleGroupsNamespaceSummary = struct {
    /// The ARN of the rule groups namespace.
    arn: []const u8,

    /// The date and time that the rule groups namespace was created.
    created_at: i64,

    /// The date and time that the rule groups namespace was most recently changed.
    modified_at: i64,

    /// The name of the rule groups namespace.
    name: []const u8,

    /// A structure that displays the current status of the rule groups namespace.
    status: RuleGroupsNamespaceStatus,

    /// The list of tag keys and values that are associated with the rule groups
    /// namespace.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
        .modified_at = "modifiedAt",
        .name = "name",
        .status = "status",
        .tags = "tags",
    };
};
