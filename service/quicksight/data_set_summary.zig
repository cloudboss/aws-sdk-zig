const aws = @import("aws");

const DataSetImportMode = @import("data_set_import_mode.zig").DataSetImportMode;
const RowLevelPermissionDataSet = @import("row_level_permission_data_set.zig").RowLevelPermissionDataSet;
const DataSetUseAs = @import("data_set_use_as.zig").DataSetUseAs;

/// Dataset summary.
pub const DataSetSummary = struct {
    /// The Amazon Resource Name (ARN) of the dataset.
    arn: ?[]const u8 = null,

    /// A value that indicates if the dataset has column level permission
    /// configured.
    column_level_permission_rules_applied: bool = false,

    /// The time that this dataset was created.
    created_time: ?i64 = null,

    /// The ID of the dataset.
    data_set_id: ?[]const u8 = null,

    /// A value that indicates whether you want to import the data into SPICE.
    import_mode: ?DataSetImportMode = null,

    /// The last time that this dataset was updated.
    last_updated_time: ?i64 = null,

    /// A display name for the dataset.
    name: ?[]const u8 = null,

    /// The row-level security configuration for the dataset in the legacy data
    /// preparation experience.
    row_level_permission_data_set: ?RowLevelPermissionDataSet = null,

    /// The row-level security configuration for the dataset in the new data
    /// preparation experience.
    row_level_permission_data_set_map: ?[]const aws.map.MapEntry(RowLevelPermissionDataSet) = null,

    /// Whether or not the row level permission tags are applied.
    row_level_permission_tag_configuration_applied: bool = false,

    /// The usage of the dataset.
    use_as: ?DataSetUseAs = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .column_level_permission_rules_applied = "ColumnLevelPermissionRulesApplied",
        .created_time = "CreatedTime",
        .data_set_id = "DataSetId",
        .import_mode = "ImportMode",
        .last_updated_time = "LastUpdatedTime",
        .name = "Name",
        .row_level_permission_data_set = "RowLevelPermissionDataSet",
        .row_level_permission_data_set_map = "RowLevelPermissionDataSetMap",
        .row_level_permission_tag_configuration_applied = "RowLevelPermissionTagConfigurationApplied",
        .use_as = "UseAs",
    };
};
