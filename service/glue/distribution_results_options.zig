const CatalogTableConfigOptions = @import("catalog_table_config_options.zig").CatalogTableConfigOptions;

/// The configuration for writing distribution results.
pub const DistributionResultsOptions = struct {
    /// The Glue Data Catalog table configuration for storing the distribution
    /// results.
    catalog_table_config: ?CatalogTableConfigOptions = null,

    /// Set to true to write distribution results.
    write_distribution_results_enabled: ?bool = null,

    pub const json_field_names = .{
        .catalog_table_config = "CatalogTableConfig",
        .write_distribution_results_enabled = "WriteDistributionResultsEnabled",
    };
};
