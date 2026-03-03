const DatasetType = @import("dataset_type.zig").DatasetType;
const DatasetStatus = @import("dataset_status.zig").DatasetStatus;

/// Properties associated with the dataset.
pub const DatasetProperties = struct {
    /// Creation time of the dataset.
    creation_time: ?i64 = null,

    /// The ARN of the dataset.
    dataset_arn: ?[]const u8 = null,

    /// The name of the dataset.
    dataset_name: ?[]const u8 = null,

    /// The S3 URI where the dataset is stored.
    dataset_s3_uri: ?[]const u8 = null,

    /// The dataset type (training data or test data).
    dataset_type: ?DatasetType = null,

    /// Description of the dataset.
    description: ?[]const u8 = null,

    /// Time when the data from the dataset becomes available in the data lake.
    end_time: ?i64 = null,

    /// A description of the status of the dataset.
    message: ?[]const u8 = null,

    /// The number of documents in the dataset.
    number_of_documents: ?i64 = null,

    /// The dataset status. While the system creates the dataset, the status is
    /// `CREATING`.
    /// When the dataset is ready to use, the status changes to `COMPLETED`.
    status: ?DatasetStatus = null,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .dataset_arn = "DatasetArn",
        .dataset_name = "DatasetName",
        .dataset_s3_uri = "DatasetS3Uri",
        .dataset_type = "DatasetType",
        .description = "Description",
        .end_time = "EndTime",
        .message = "Message",
        .number_of_documents = "NumberOfDocuments",
        .status = "Status",
    };
};
