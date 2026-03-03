const aws = @import("aws");

const CaseRuleDetails = @import("case_rule_details.zig").CaseRuleDetails;

/// Detailed case rule information. In the Amazon Connect admin website, case
/// rules are known as *case field conditions*. For more information about case
/// field conditions, see [Add case field conditions to a case
/// template](https://docs.aws.amazon.com/connect/latest/adminguide/case-field-conditions.html).
pub const GetCaseRuleResponse = struct {
    /// The Amazon Resource Name (ARN) of the case rule.
    case_rule_arn: []const u8,

    /// Unique identifier of a case rule.
    case_rule_id: []const u8,

    /// Timestamp when the resource was created.
    created_time: ?i64 = null,

    /// Indicates whether the resource has been deleted.
    deleted: bool = false,

    /// Description of a case rule.
    description: ?[]const u8 = null,

    /// Timestamp when the resource was created or last modified.
    last_modified_time: ?i64 = null,

    /// Name of the case rule.
    name: []const u8,

    /// Represents what rule type should take place, under what conditions.
    rule: CaseRuleDetails,

    /// A map of of key-value pairs that represent tags on a resource. Tags are used
    /// to organize, track, or control access for this resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .case_rule_arn = "caseRuleArn",
        .case_rule_id = "caseRuleId",
        .created_time = "createdTime",
        .deleted = "deleted",
        .description = "description",
        .last_modified_time = "lastModifiedTime",
        .name = "name",
        .rule = "rule",
        .tags = "tags",
    };
};
