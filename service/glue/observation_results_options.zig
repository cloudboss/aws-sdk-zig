const CatalogTableConfigOptions = @import("catalog_table_config_options.zig").CatalogTableConfigOptions;

/// The configuration for writing observation results.
pub const ObservationResultsOptions = struct {
    /// The Glue Data Catalog table configuration for storing the observation
    /// results.
    catalog_table_config: ?CatalogTableConfigOptions = null,

    /// Set to true to write observation results.
    write_observation_results_enabled: ?bool = null,

    pub const json_field_names = .{
        .catalog_table_config = "CatalogTableConfig",
        .write_observation_results_enabled = "WriteObservationResultsEnabled",
    };
};
