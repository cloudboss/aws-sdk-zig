const aws = @import("aws");

/// Actions defined in the Glue Studio data preparation recipe node.
pub const RecipeAction = struct {
    /// The operation of the recipe action.
    operation: []const u8,

    /// The parameters of the recipe action.
    parameters: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .operation = "Operation",
        .parameters = "Parameters",
    };
};
