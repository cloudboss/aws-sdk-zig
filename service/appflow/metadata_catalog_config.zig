const GlueDataCatalogConfig = @import("glue_data_catalog_config.zig").GlueDataCatalogConfig;

/// Specifies the configuration that Amazon AppFlow uses when it catalogs your
/// data. When
/// Amazon AppFlow catalogs your data, it stores metadata in a data catalog.
pub const MetadataCatalogConfig = struct {
    /// Specifies the configuration that Amazon AppFlow uses when it catalogs your
    /// data with
    /// the Glue Data Catalog.
    glue_data_catalog: ?GlueDataCatalogConfig = null,

    pub const json_field_names = .{
        .glue_data_catalog = "glueDataCatalog",
    };
};
