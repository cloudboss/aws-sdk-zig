const RuleCategory = @import("rule_category.zig").RuleCategory;
const RuleOwner = @import("rule_owner.zig").RuleOwner;

/// The ID for the rule type, which is made up of the combined values for
/// category, owner,
/// provider, and version. For more information about conditions, see [Stage
/// conditions](https://docs.aws.amazon.com/codepipeline/latest/userguide/stage-conditions.html). For more information about rules, see the [CodePipeline rule reference](https://docs.aws.amazon.com/codepipeline/latest/userguide/rule-reference.html).
pub const RuleTypeId = struct {
    /// A category defines what kind of rule can be run in the stage, and constrains
    /// the
    /// provider type for the rule. The valid category is `Rule`.
    category: RuleCategory,

    /// The creator of the rule being called. The valid value for the `Owner` field
    /// in the rule category is `AWS`.
    owner: ?RuleOwner,

    /// The rule provider, such as the `DeploymentWindow` rule. For a list of rule
    /// provider names, see the rules listed in the [CodePipeline rule
    /// reference](https://docs.aws.amazon.com/codepipeline/latest/userguide/rule-reference.html).
    provider: []const u8,

    /// A string that describes the rule version.
    version: ?[]const u8,

    pub const json_field_names = .{
        .category = "category",
        .owner = "owner",
        .provider = "provider",
        .version = "version",
    };
};
