/// When the solution performs AutoML (`performAutoML` is true in
/// [CreateSolution](https://docs.aws.amazon.com/personalize/latest/dg/API_CreateSolution.html)), specifies the recipe that best optimized the
/// specified metric.
pub const AutoMLResult = struct {
    /// The Amazon Resource Name (ARN) of the best recipe.
    best_recipe_arn: ?[]const u8,

    pub const json_field_names = .{
        .best_recipe_arn = "bestRecipeArn",
    };
};
