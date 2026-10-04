const DraftStatus = @import("draft_status.zig").DraftStatus;
const DatasetSchemaType = @import("dataset_schema_type.zig").DatasetSchemaType;
const DatasetStatus = @import("dataset_status.zig").DatasetStatus;

/// Summary information about a dataset.
pub const DatasetSummary = struct {
    /// The timestamp when the dataset was created.
    created_at: i64,

    /// The Amazon Resource Name (ARN) of the dataset.
    dataset_arn: []const u8,

    /// The unique identifier of the dataset.
    dataset_id: []const u8,

    /// The name of the dataset.
    dataset_name: []const u8,

    /// The description of the dataset.
    description: ?[]const u8 = null,

    /// Publish synchronization state. Only authoritative when status is ACTIVE.
    draft_status: ?DraftStatus = null,

    /// The number of examples in the dataset.
    example_count: i64,

    /// The schema type of the dataset.
    schema_type: DatasetSchemaType,

    /// The current status of the dataset.
    status: DatasetStatus,

    /// The timestamp when the dataset was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .dataset_arn = "datasetArn",
        .dataset_id = "datasetId",
        .dataset_name = "datasetName",
        .description = "description",
        .draft_status = "draftStatus",
        .example_count = "exampleCount",
        .schema_type = "schemaType",
        .status = "status",
        .updated_at = "updatedAt",
    };
};
