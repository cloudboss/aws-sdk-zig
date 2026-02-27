/// Represents any errors encountered when attempting to delete multiple recipe
/// versions.
pub const RecipeVersionErrorDetail = struct {
    /// The HTTP status code for the error.
    error_code: ?[]const u8,

    /// The text of the error message.
    error_message: ?[]const u8,

    /// The identifier for the recipe version associated with this error.
    recipe_version: ?[]const u8,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
        .error_message = "ErrorMessage",
        .recipe_version = "RecipeVersion",
    };
};
