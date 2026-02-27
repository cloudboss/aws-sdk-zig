const UpdateCatalogBehavior = @import("update_catalog_behavior.zig").UpdateCatalogBehavior;

/// A policy that specifies update behavior for the crawler.
pub const DirectSchemaChangePolicy = struct {
    /// Specifies the database that the schema change policy applies to.
    database: ?[]const u8,

    /// Whether to use the specified update behavior when the crawler finds a
    /// changed schema.
    enable_update_catalog: ?bool,

    /// Specifies the table in the database that the schema change policy applies
    /// to.
    table: ?[]const u8,

    /// The update behavior when the crawler finds a changed schema.
    update_behavior: ?UpdateCatalogBehavior,

    pub const json_field_names = .{
        .database = "Database",
        .enable_update_catalog = "EnableUpdateCatalog",
        .table = "Table",
        .update_behavior = "UpdateBehavior",
    };
};
