const aws = @import("aws");

const RuleGroupsNamespaceStatus = @import("rule_groups_namespace_status.zig").RuleGroupsNamespaceStatus;

/// The details about one rule groups namespace.
pub const RuleGroupsNamespaceDescription = struct {
    /// The ARN of the rule groups namespace. For example,
    /// `arn:aws:aps:<region>:123456789012:rulegroupsnamespace/ws-example1-1234-abcd-5678-ef90abcd1234/rulesfile1`.
    arn: []const u8,

    /// The date and time that the rule groups namespace was created.
    created_at: i64,

    /// The rule groups file used in the namespace.
    ///
    /// For details about the rule groups namespace structure, see
    /// [RuleGroupsNamespaceData](https://docs.aws.amazon.com/prometheus/latest/APIReference/yaml-RuleGroupsNamespaceData.html).
    data: []const u8,

    /// The date and time that the rule groups namespace was most recently changed.
    modified_at: i64,

    /// The name of the rule groups namespace.
    name: []const u8,

    /// The current status of the rule groups namespace.
    status: RuleGroupsNamespaceStatus,

    /// The list of tag keys and values that are associated with the rule groups
    /// namespace.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
        .data = "data",
        .modified_at = "modifiedAt",
        .name = "name",
        .status = "status",
        .tags = "tags",
    };
};
