const Domain = @import("domain.zig").Domain;

/// Provides a summary of the properties of a recipe. For a complete listing,
/// call the
/// [DescribeRecipe](https://docs.aws.amazon.com/personalize/latest/dg/API_DescribeRecipe.html) API.
pub const RecipeSummary = struct {
    /// The date and time (in Unix time) that the recipe was created.
    creation_date_time: ?i64,

    /// The domain of the recipe (if the recipe is a Domain dataset group use case).
    domain: ?Domain,

    /// The date and time (in Unix time) that the recipe was last updated.
    last_updated_date_time: ?i64,

    /// The name of the recipe.
    name: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the recipe.
    recipe_arn: ?[]const u8,

    /// The status of the recipe.
    status: ?[]const u8,

    pub const json_field_names = .{
        .creation_date_time = "creationDateTime",
        .domain = "domain",
        .last_updated_date_time = "lastUpdatedDateTime",
        .name = "name",
        .recipe_arn = "recipeArn",
        .status = "status",
    };
};
