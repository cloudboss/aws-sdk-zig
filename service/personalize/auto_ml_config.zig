/// When the solution performs AutoML (`performAutoML` is true in
/// [CreateSolution](https://docs.aws.amazon.com/personalize/latest/dg/API_CreateSolution.html)), Amazon Personalize
/// determines which recipe, from the specified list, optimizes the given
/// metric.
/// Amazon Personalize then uses that recipe for the solution.
pub const AutoMLConfig = struct {
    /// The metric to optimize.
    metric_name: ?[]const u8,

    /// The list of candidate recipes.
    recipe_list: ?[]const []const u8,

    pub const json_field_names = .{
        .metric_name = "metricName",
        .recipe_list = "recipeList",
    };
};
