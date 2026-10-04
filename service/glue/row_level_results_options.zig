const CatalogTableConfigOptions = @import("catalog_table_config_options.zig").CatalogTableConfigOptions;
const ResultTypeEnum = @import("result_type_enum.zig").ResultTypeEnum;

/// The configuration for writing row-level evaluation results.
pub const RowLevelResultsOptions = struct {
    /// The Glue Data Catalog table configuration for storing the results.
    catalog_table_config: ?CatalogTableConfigOptions = null,

    /// The maximum number of rows to write in the results.
    max_rows_to_write: ?i32 = null,

    /// The result type to include in the row-level results output.
    result_type: ?ResultTypeEnum = null,

    pub const json_field_names = .{
        .catalog_table_config = "CatalogTableConfig",
        .max_rows_to_write = "MaxRowsToWrite",
        .result_type = "ResultType",
    };
};
