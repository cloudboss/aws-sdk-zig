const DataLakeDatasetSchemaField = @import("data_lake_dataset_schema_field.zig").DataLakeDatasetSchemaField;
const DataLakeDatasetPrimaryKeyField = @import("data_lake_dataset_primary_key_field.zig").DataLakeDatasetPrimaryKeyField;

/// The schema details of the dataset. Note that for AWS Supply Chain dataset
/// under **asc** namespace, it may have internal fields like connection_id that
/// will be auto populated by data ingestion methods.
pub const DataLakeDatasetSchema = struct {
    /// The list of field details of the dataset schema.
    fields: []const DataLakeDatasetSchemaField,

    /// The name of the dataset schema.
    name: []const u8,

    /// The list of primary key fields for the dataset. Primary keys defined can
    /// help data ingestion methods to ensure data uniqueness:
    /// CreateDataIntegrationFlow's dedupe strategy will leverage primary keys to
    /// perform records deduplication before write to dataset;
    /// SendDataIntegrationEvent's UPSERT and DELETE can only work with dataset with
    /// primary keys. For more details, refer to those data ingestion
    /// documentations.
    ///
    /// Note that defining primary keys does not necessarily mean the dataset cannot
    /// have duplicate records, duplicate records can still be ingested if
    /// CreateDataIntegrationFlow's dedupe disabled or through
    /// SendDataIntegrationEvent's APPEND operation.
    primary_keys: ?[]const DataLakeDatasetPrimaryKeyField = null,

    pub const json_field_names = .{
        .fields = "fields",
        .name = "name",
        .primary_keys = "primaryKeys",
    };
};
