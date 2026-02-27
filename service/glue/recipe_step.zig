const RecipeAction = @import("recipe_action.zig").RecipeAction;
const ConditionExpression = @import("condition_expression.zig").ConditionExpression;

/// A recipe step used in a Glue Studio data preparation recipe node.
pub const RecipeStep = struct {
    /// The transformation action of the recipe step.
    action: RecipeAction,

    /// The condition expressions for the recipe step.
    condition_expressions: ?[]const ConditionExpression,

    pub const json_field_names = .{
        .action = "Action",
        .condition_expressions = "ConditionExpressions",
    };
};
