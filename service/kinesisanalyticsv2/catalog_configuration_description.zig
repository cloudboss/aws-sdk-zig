const GlueDataCatalogConfigurationDescription = @import("glue_data_catalog_configuration_description.zig").GlueDataCatalogConfigurationDescription;

/// The configuration parameters for the default Amazon Glue database. You use
/// this database for Apache Flink SQL queries and table API transforms that you
/// write in a Managed Service for Apache Flink Studio notebook.
pub const CatalogConfigurationDescription = struct {
    /// The configuration parameters for the default Amazon Glue database. You use
    /// this database for SQL queries that you write in a Managed Service for Apache
    /// Flink Studio notebook.
    glue_data_catalog_configuration_description: GlueDataCatalogConfigurationDescription,

    pub const json_field_names = .{
        .glue_data_catalog_configuration_description = "GlueDataCatalogConfigurationDescription",
    };
};
