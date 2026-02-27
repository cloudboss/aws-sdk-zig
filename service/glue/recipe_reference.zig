/// A reference to a Glue DataBrew recipe.
pub const RecipeReference = struct {
    /// The ARN of the DataBrew recipe.
    recipe_arn: []const u8,

    /// The RecipeVersion of the DataBrew recipe.
    recipe_version: []const u8,

    pub const json_field_names = .{
        .recipe_arn = "RecipeArn",
        .recipe_version = "RecipeVersion",
    };
};
