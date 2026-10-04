const CatalogTableConfigOptions = @import("catalog_table_config_options.zig").CatalogTableConfigOptions;
const DistributionResultsOptions = @import("distribution_results_options.zig").DistributionResultsOptions;

/// The configuration for writing profiling results.
pub const ProfilingResultsOptions = struct {
    /// The Glue Data Catalog table configuration for storing the profiling results.
    catalog_table_config: ?CatalogTableConfigOptions = null,

    /// The configuration for writing distribution results.
    distribution_results: ?DistributionResultsOptions = null,

    /// Set to true to write profiling results.
    write_profiling_results_enabled: ?bool = null,

    pub const json_field_names = .{
        .catalog_table_config = "CatalogTableConfig",
        .distribution_results = "DistributionResults",
        .write_profiling_results_enabled = "WriteProfilingResultsEnabled",
    };
};
