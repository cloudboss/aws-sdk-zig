/// Identifies the foundation model that was used as the starting point for
/// model customization.
pub const BaseModel = struct {
    /// The hub content name of the base model.
    hub_content_name: ?[]const u8 = null,

    /// The hub content version of the base model.
    hub_content_version: ?[]const u8 = null,

    /// The recipe name of the base model.
    recipe_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .hub_content_name = "HubContentName",
        .hub_content_version = "HubContentVersion",
        .recipe_name = "RecipeName",
    };
};
