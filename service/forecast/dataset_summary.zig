const DatasetType = @import("dataset_type.zig").DatasetType;
const Domain = @import("domain.zig").Domain;

/// Provides a summary of the dataset properties used in the
/// [ListDatasets](https://docs.aws.amazon.com/forecast/latest/dg/API_ListDatasets.html) operation. To get the
/// complete set of properties, call the
/// [DescribeDataset](https://docs.aws.amazon.com/forecast/latest/dg/API_DescribeDataset.html) operation, and
/// provide the `DatasetArn`.
pub const DatasetSummary = struct {
    /// When the dataset was created.
    creation_time: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the dataset.
    dataset_arn: ?[]const u8 = null,

    /// The name of the dataset.
    dataset_name: ?[]const u8 = null,

    /// The dataset type.
    dataset_type: ?DatasetType = null,

    /// The domain associated with the dataset.
    domain: ?Domain = null,

    /// When you create a dataset, `LastModificationTime` is the same as
    /// `CreationTime`. While data is being imported to the dataset,
    /// `LastModificationTime` is the current time of the `ListDatasets` call.
    /// After a
    /// [CreateDatasetImportJob](https://docs.aws.amazon.com/forecast/latest/dg/API_CreateDatasetImportJob.html) operation has finished, `LastModificationTime` is
    /// when the import job completed or failed.
    last_modification_time: ?i64 = null,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .dataset_arn = "DatasetArn",
        .dataset_name = "DatasetName",
        .dataset_type = "DatasetType",
        .domain = "Domain",
        .last_modification_time = "LastModificationTime",
    };
};
