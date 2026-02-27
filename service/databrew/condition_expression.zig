/// Represents an individual condition that evaluates to true or false.
///
/// Conditions are used with recipe actions. The action is only performed for
/// column values where the
/// condition evaluates to true.
///
/// If a recipe requires more than one condition, then the recipe must specify
/// multiple
/// `ConditionExpression` elements. Each condition is applied to the rows in a
/// dataset first, before
/// the recipe action is performed.
pub const ConditionExpression = struct {
    /// A specific condition to apply to a recipe action. For more information, see
    /// [Recipe
    /// structure](https://docs.aws.amazon.com/databrew/latest/dg/recipes.html#recipes.structure) in the *Glue DataBrew Developer
    /// Guide*.
    condition: []const u8,

    /// A column to apply this condition to.
    target_column: []const u8,

    /// A value that the condition must evaluate to for the condition to succeed.
    value: ?[]const u8,

    pub const json_field_names = .{
        .condition = "Condition",
        .target_column = "TargetColumn",
        .value = "Value",
    };
};
