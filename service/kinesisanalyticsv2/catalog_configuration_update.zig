const GlueDataCatalogConfigurationUpdate = @import("glue_data_catalog_configuration_update.zig").GlueDataCatalogConfigurationUpdate;

/// Updates to the configuration parameters for the default Amazon Glue
/// database. You use this database for SQL queries that you write in a Managed
/// Service for Apache Flink Studio notebook.
pub const CatalogConfigurationUpdate = struct {
    /// Updates to the configuration parameters for the default Amazon Glue
    /// database. You use this database for SQL queries that you write in a Managed
    /// Service for Apache Flink Studio notebook.
    glue_data_catalog_configuration_update: GlueDataCatalogConfigurationUpdate,

    pub const json_field_names = .{
        .glue_data_catalog_configuration_update = "GlueDataCatalogConfigurationUpdate",
    };
};
