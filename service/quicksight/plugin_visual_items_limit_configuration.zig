/// A query limits configuration.
pub const PluginVisualItemsLimitConfiguration = struct {
    /// Determines how many values are be fetched at once.
    items_limit: ?i64 = null,

    pub const json_field_names = .{
        .items_limit = "ItemsLimit",
    };
};
