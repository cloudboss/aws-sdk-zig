const RecommenderRecipeName = @import("recommender_recipe_name.zig").RecommenderRecipeName;

/// Defines the algorithm and approach used to generate recommendations.
pub const RecommenderRecipe = struct {
    /// A description of the recommender recipe's purpose and functionality.
    description: ?[]const u8,

    /// The name of the recommender recipe.
    name: ?RecommenderRecipeName,

    pub const json_field_names = .{
        .description = "description",
        .name = "name",
    };
};
