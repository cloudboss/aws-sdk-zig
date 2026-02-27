const aws = @import("aws");

/// Represents a transformation and associated parameters that are used to apply
/// a change
/// to a DataBrew dataset. For more information, see [Recipe
/// actions
/// reference](https://docs.aws.amazon.com/databrew/latest/dg/recipe-actions-reference.html).
pub const RecipeAction = struct {
    /// The name of a valid DataBrew transformation to be performed on the data.
    operation: []const u8,

    /// Contextual parameters for the transformation.
    parameters: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .operation = "Operation",
        .parameters = "Parameters",
    };
};
