const RecipeReference = @import("recipe_reference.zig").RecipeReference;
const RecipeStep = @import("recipe_step.zig").RecipeStep;

/// A Glue Studio node that uses a Glue DataBrew recipe in Glue jobs.
pub const Recipe = struct {
    /// The nodes that are inputs to the recipe node, identified by id.
    inputs: []const []const u8,

    /// The name of the Glue Studio node.
    name: []const u8,

    /// A reference to the DataBrew recipe used by the node.
    recipe_reference: ?RecipeReference = null,

    /// Transform steps used in the recipe node.
    recipe_steps: ?[]const RecipeStep = null,

    pub const json_field_names = .{
        .inputs = "Inputs",
        .name = "Name",
        .recipe_reference = "RecipeReference",
        .recipe_steps = "RecipeSteps",
    };
};
