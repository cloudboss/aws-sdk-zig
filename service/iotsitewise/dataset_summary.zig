const DatasetTypeEnum = @import("dataset_type_enum.zig").DatasetTypeEnum;
const DatasetEnrichment = @import("dataset_enrichment.zig").DatasetEnrichment;
const DatasetSourceType = @import("dataset_source_type.zig").DatasetSourceType;
const DatasetStatus = @import("dataset_status.zig").DatasetStatus;

/// The summary details for the dataset.
pub const DatasetSummary = struct {
    /// The
    /// [ARN](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference-arns.html)
    /// of the dataset.
    /// The format is
    /// `arn:${Partition}:iotsitewise:${Region}:${Account}:dataset/${DatasetId}`.
    arn: []const u8,

    /// The dataset creation date, in Unix epoch time.
    creation_date: i64,

    /// The type of dataset: a session dataset, a curated dataset, or a connection
    /// to an external
    /// datasource.
    dataset_type: ?DatasetTypeEnum = null,

    /// A description about the dataset, and its functionality.
    description: []const u8,

    /// The enrichment status of the dataset.
    enrichment_status: ?DatasetEnrichment = null,

    /// The ID of the dataset.
    id: []const u8,

    /// The date the dataset was last updated, in Unix epoch time.
    last_update_date: i64,

    /// The name of the dataset.
    name: []const u8,

    /// The data source type of the dataset.
    source_type: ?DatasetSourceType = null,

    /// The status of the dataset. This contains the state and any error messages.
    /// The state is
    /// `ACTIVE` when ready to use.
    status: DatasetStatus,

    pub const json_field_names = .{
        .arn = "arn",
        .creation_date = "creationDate",
        .dataset_type = "datasetType",
        .description = "description",
        .enrichment_status = "enrichmentStatus",
        .id = "id",
        .last_update_date = "lastUpdateDate",
        .name = "name",
        .source_type = "sourceType",
        .status = "status",
    };
};
