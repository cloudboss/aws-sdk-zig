const aws = @import("aws");

const LifecyclePolicyResourceSelectionRecipe = @import("lifecycle_policy_resource_selection_recipe.zig").LifecyclePolicyResourceSelectionRecipe;

/// Resource selection criteria for the lifecycle policy.
pub const LifecyclePolicyResourceSelection = struct {
    /// A list of recipes that are used as selection criteria for the output
    /// images that the lifecycle policy applies to.
    recipes: ?[]const LifecyclePolicyResourceSelectionRecipe = null,

    /// A list of tags that are used as selection criteria for the Image Builder
    /// image
    /// resources that the lifecycle policy applies to.
    tag_map: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .recipes = "recipes",
        .tag_map = "tagMap",
    };
};
