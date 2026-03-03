const Result = @import("result.zig").Result;
const RuleDeclaration = @import("rule_declaration.zig").RuleDeclaration;

/// The condition for the stage. A condition is made up of the rules and the
/// result for
/// the condition. For more information about conditions, see [Stage
/// conditions](https://docs.aws.amazon.com/codepipeline/latest/userguide/stage-conditions.html)
/// and [How do
/// stage conditions
/// work?](https://docs.aws.amazon.com/codepipeline/latest/userguide/concepts-how-it-works-conditions.html).. For more information about rules, see the [CodePipeline rule reference](https://docs.aws.amazon.com/codepipeline/latest/userguide/rule-reference.html).
pub const Condition = struct {
    /// The action to be done when the condition is met. For example, rolling back
    /// an
    /// execution for a failure condition.
    result: ?Result = null,

    /// The rules that make up the condition.
    rules: ?[]const RuleDeclaration = null,

    pub const json_field_names = .{
        .result = "result",
        .rules = "rules",
    };
};
