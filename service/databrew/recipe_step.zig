const RecipeAction = @import("recipe_action.zig").RecipeAction;
const ConditionExpression = @import("condition_expression.zig").ConditionExpression;

/// Represents a single step from a DataBrew recipe to be performed.
pub const RecipeStep = struct {
    /// The particular action to be performed in the recipe step.
    action: RecipeAction,

    /// One or more conditions that must be met for the recipe step to succeed.
    ///
    /// All of the conditions in the array must be met. In other words, all of the
    /// conditions must be combined using a logical AND operation.
    condition_expressions: ?[]const ConditionExpression = null,

    pub const json_field_names = .{
        .action = "Action",
        .condition_expressions = "ConditionExpressions",
    };
};
