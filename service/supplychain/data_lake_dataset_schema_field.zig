const DataLakeDatasetSchemaFieldType = @import("data_lake_dataset_schema_field_type.zig").DataLakeDatasetSchemaFieldType;

/// The dataset field details.
pub const DataLakeDatasetSchemaField = struct {
    /// Indicate if the field is required or not.
    is_required: bool,

    /// The dataset field name.
    name: []const u8,

    /// The dataset field type.
    @"type": DataLakeDatasetSchemaFieldType,

    pub const json_field_names = .{
        .is_required = "isRequired",
        .name = "name",
        .@"type" = "type",
    };
};
