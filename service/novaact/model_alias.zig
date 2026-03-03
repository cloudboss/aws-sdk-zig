/// An alias that provides a stable reference to a model version.
pub const ModelAlias = struct {
    /// The name of the model alias.
    alias_name: []const u8,

    /// The model ID that this alias currently points to.
    latest_model_id: []const u8,

    /// The resolved model ID after alias resolution.
    resolved_model_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .alias_name = "aliasName",
        .latest_model_id = "latestModelId",
        .resolved_model_id = "resolvedModelId",
    };
};
