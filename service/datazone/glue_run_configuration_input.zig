const RelationalFilterConfiguration = @import("relational_filter_configuration.zig").RelationalFilterConfiguration;

/// The configuration details of the Amazon Web Services Glue data source.
pub const GlueRunConfigurationInput = struct {
    /// Specifies whether to automatically import data quality metrics as part of
    /// the data source run.
    auto_import_data_quality_result: ?bool = null,

    /// The catalog name in the Amazon Web Services Glue run configuration.
    catalog_name: ?[]const u8 = null,

    /// The data access role included in the configuration details of the Amazon Web
    /// Services Glue data source.
    data_access_role: ?[]const u8 = null,

    /// The relational filter configurations included in the configuration details
    /// of the Amazon Web Services Glue data source.
    relational_filter_configurations: []const RelationalFilterConfiguration,

    pub const json_field_names = .{
        .auto_import_data_quality_result = "autoImportDataQualityResult",
        .catalog_name = "catalogName",
        .data_access_role = "dataAccessRole",
        .relational_filter_configurations = "relationalFilterConfigurations",
    };
};
