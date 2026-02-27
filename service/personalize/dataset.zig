const DatasetUpdateSummary = @import("dataset_update_summary.zig").DatasetUpdateSummary;

/// Provides metadata for a dataset.
pub const Dataset = struct {
    /// The creation date and time (in Unix time) of the dataset.
    creation_date_time: ?i64,

    /// The Amazon Resource Name (ARN) of the dataset that you want metadata
    /// for.
    dataset_arn: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the dataset group.
    dataset_group_arn: ?[]const u8,

    /// One of the following values:
    ///
    /// * Interactions
    ///
    /// * Items
    ///
    /// * Users
    ///
    /// * Actions
    ///
    /// * Action_Interactions
    dataset_type: ?[]const u8,

    /// A time stamp that shows when the dataset was updated.
    last_updated_date_time: ?i64,

    /// Describes the latest update to the dataset.
    latest_dataset_update: ?DatasetUpdateSummary,

    /// The name of the dataset.
    name: ?[]const u8,

    /// The ARN of the associated schema.
    schema_arn: ?[]const u8,

    /// The status of the dataset.
    ///
    /// A dataset can be in one of the following states:
    ///
    /// * CREATE PENDING > CREATE IN_PROGRESS > ACTIVE -or- CREATE
    /// FAILED
    ///
    /// * DELETE PENDING > DELETE IN_PROGRESS
    status: ?[]const u8,

    /// The ID of the event tracker for an Action interactions dataset.
    /// You specify the tracker's ID in the `PutActionInteractions` API operation.
    /// Amazon Personalize uses it to direct new data to the Action interactions
    /// dataset in your dataset group.
    tracking_id: ?[]const u8,

    pub const json_field_names = .{
        .creation_date_time = "creationDateTime",
        .dataset_arn = "datasetArn",
        .dataset_group_arn = "datasetGroupArn",
        .dataset_type = "datasetType",
        .last_updated_date_time = "lastUpdatedDateTime",
        .latest_dataset_update = "latestDatasetUpdate",
        .name = "name",
        .schema_arn = "schemaArn",
        .status = "status",
        .tracking_id = "trackingId",
    };
};
