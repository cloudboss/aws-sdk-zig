const CatalogTableConfigOptions = @import("catalog_table_config_options.zig").CatalogTableConfigOptions;

/// The configuration for writing data quality rule results.
pub const DataQualityRuleResultsOptions = struct {
    /// The Glue Data Catalog table configuration for storing the rule results.
    catalog_table_config: ?CatalogTableConfigOptions = null,

    /// Set to true to write data quality rule results.
    write_data_quality_rule_results_enabled: ?bool = null,

    pub const json_field_names = .{
        .catalog_table_config = "CatalogTableConfig",
        .write_data_quality_rule_results_enabled = "WriteDataQualityRuleResultsEnabled",
    };
};
