const UpdateCatalogBehavior = @import("update_catalog_behavior.zig").UpdateCatalogBehavior;

/// A policy that specifies update behavior for the crawler.
pub const CatalogSchemaChangePolicy = struct {
    /// Whether to use the specified update behavior when the crawler finds a
    /// changed schema.
    enable_update_catalog: ?bool,

    /// The update behavior when the crawler finds a changed schema.
    update_behavior: ?UpdateCatalogBehavior,

    pub const json_field_names = .{
        .enable_update_catalog = "EnableUpdateCatalog",
        .update_behavior = "UpdateBehavior",
    };
};
