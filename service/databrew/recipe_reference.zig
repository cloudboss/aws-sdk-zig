/// Represents the name and version of a DataBrew recipe.
pub const RecipeReference = struct {
    /// The name of the recipe.
    name: []const u8,

    /// The identifier for the version for the recipe.
    recipe_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .name = "Name",
        .recipe_version = "RecipeVersion",
    };
};
