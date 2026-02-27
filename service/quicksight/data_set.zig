const aws = @import("aws");

const ColumnGroup = @import("column_group.zig").ColumnGroup;
const ColumnLevelPermissionRule = @import("column_level_permission_rule.zig").ColumnLevelPermissionRule;
const DataPrepConfiguration = @import("data_prep_configuration.zig").DataPrepConfiguration;
const DatasetParameter = @import("dataset_parameter.zig").DatasetParameter;
const DataSetUsageConfiguration = @import("data_set_usage_configuration.zig").DataSetUsageConfiguration;
const FieldFolder = @import("field_folder.zig").FieldFolder;
const DataSetImportMode = @import("data_set_import_mode.zig").DataSetImportMode;
const LogicalTable = @import("logical_table.zig").LogicalTable;
const OutputColumn = @import("output_column.zig").OutputColumn;
const PerformanceConfiguration = @import("performance_configuration.zig").PerformanceConfiguration;
const PhysicalTable = @import("physical_table.zig").PhysicalTable;
const RowLevelPermissionDataSet = @import("row_level_permission_data_set.zig").RowLevelPermissionDataSet;
const RowLevelPermissionTagConfiguration = @import("row_level_permission_tag_configuration.zig").RowLevelPermissionTagConfiguration;
const SemanticModelConfiguration = @import("semantic_model_configuration.zig").SemanticModelConfiguration;
const DataSetUseAs = @import("data_set_use_as.zig").DataSetUseAs;

/// Dataset.
pub const DataSet = struct {
    /// The Amazon Resource Name (ARN) of the resource.
    arn: ?[]const u8,

    /// Groupings of columns that work together in certain Quick Sight features.
    /// Currently, only geospatial hierarchy is supported.
    column_groups: ?[]const ColumnGroup,

    /// A set of one or more definitions of a `
    /// [ColumnLevelPermissionRule](https://docs.aws.amazon.com/quicksight/latest/APIReference/API_ColumnLevelPermissionRule.html)
    /// `.
    column_level_permission_rules: ?[]const ColumnLevelPermissionRule,

    /// The amount of SPICE capacity used by this dataset. This is 0 if the dataset
    /// isn't
    /// imported into SPICE.
    consumed_spice_capacity_in_bytes: i64 = 0,

    /// The time that this dataset was created.
    created_time: ?i64,

    /// The data preparation configuration associated with this dataset.
    data_prep_configuration: ?DataPrepConfiguration,

    /// The ID of the dataset. Limited to 96 characters.
    data_set_id: ?[]const u8,

    /// The parameters that are declared in a dataset.
    dataset_parameters: ?[]const DatasetParameter,

    /// The usage configuration to apply to child datasets that reference this
    /// dataset as a source.
    data_set_usage_configuration: ?DataSetUsageConfiguration,

    /// The folder that contains fields and nested subfolders for your dataset.
    field_folders: ?[]const aws.map.MapEntry(FieldFolder),

    /// A value that indicates whether you want to import the data into SPICE.
    import_mode: ?DataSetImportMode,

    /// The last time that this dataset was updated.
    last_updated_time: ?i64,

    /// Configures the combination and transformation of the data from the physical
    /// tables.
    logical_table_map: ?[]const aws.map.MapEntry(LogicalTable),

    /// A display name for the dataset.
    name: ?[]const u8,

    /// The list of columns after all transforms. These columns are available in
    /// templates,
    /// analyses, and dashboards.
    output_columns: ?[]const OutputColumn,

    /// The performance optimization configuration of a dataset.
    performance_configuration: ?PerformanceConfiguration,

    /// Declares the physical tables that are available in the underlying data
    /// sources.
    physical_table_map: ?[]const aws.map.MapEntry(PhysicalTable),

    /// The row-level security configuration for the dataset.
    row_level_permission_data_set: ?RowLevelPermissionDataSet,

    /// The element you can use to define tags for row-level security.
    row_level_permission_tag_configuration: ?RowLevelPermissionTagConfiguration,

    /// The semantic model configuration associated with this dataset.
    semantic_model_configuration: ?SemanticModelConfiguration,

    /// The usage of the dataset.
    use_as: ?DataSetUseAs,

    pub const json_field_names = .{
        .arn = "Arn",
        .column_groups = "ColumnGroups",
        .column_level_permission_rules = "ColumnLevelPermissionRules",
        .consumed_spice_capacity_in_bytes = "ConsumedSpiceCapacityInBytes",
        .created_time = "CreatedTime",
        .data_prep_configuration = "DataPrepConfiguration",
        .data_set_id = "DataSetId",
        .dataset_parameters = "DatasetParameters",
        .data_set_usage_configuration = "DataSetUsageConfiguration",
        .field_folders = "FieldFolders",
        .import_mode = "ImportMode",
        .last_updated_time = "LastUpdatedTime",
        .logical_table_map = "LogicalTableMap",
        .name = "Name",
        .output_columns = "OutputColumns",
        .performance_configuration = "PerformanceConfiguration",
        .physical_table_map = "PhysicalTableMap",
        .row_level_permission_data_set = "RowLevelPermissionDataSet",
        .row_level_permission_tag_configuration = "RowLevelPermissionTagConfiguration",
        .semantic_model_configuration = "SemanticModelConfiguration",
        .use_as = "UseAs",
    };
};
