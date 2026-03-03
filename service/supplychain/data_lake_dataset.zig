const DataLakeDatasetPartitionSpec = @import("data_lake_dataset_partition_spec.zig").DataLakeDatasetPartitionSpec;
const DataLakeDatasetSchema = @import("data_lake_dataset_schema.zig").DataLakeDatasetSchema;

/// The data lake dataset details.
pub const DataLakeDataset = struct {
    /// The arn of the dataset.
    arn: []const u8,

    /// The creation time of the dataset.
    created_time: i64,

    /// The description of the dataset.
    description: ?[]const u8 = null,

    /// The Amazon Web Services Supply Chain instance identifier.
    instance_id: []const u8,

    /// The last modified time of the dataset.
    last_modified_time: i64,

    /// The name of the dataset. For **asc** namespace, the name must be one of the
    /// supported data entities under
    /// [https://docs.aws.amazon.com/aws-supply-chain/latest/userguide/data-model-asc.html](https://docs.aws.amazon.com/aws-supply-chain/latest/userguide/data-model-asc.html).
    name: []const u8,

    /// The namespace of the dataset, besides the custom defined namespace, every
    /// instance comes with below pre-defined namespaces:
    ///
    /// * **asc** - For information on the Amazon Web Services Supply Chain
    ///   supported datasets see
    ///   [https://docs.aws.amazon.com/aws-supply-chain/latest/userguide/data-model-asc.html](https://docs.aws.amazon.com/aws-supply-chain/latest/userguide/data-model-asc.html).
    ///
    /// * **default** - For datasets with custom user-defined schemas.
    namespace: []const u8,

    partition_spec: ?DataLakeDatasetPartitionSpec = null,

    /// The schema of the dataset.
    schema: DataLakeDatasetSchema,

    pub const json_field_names = .{
        .arn = "arn",
        .created_time = "createdTime",
        .description = "description",
        .instance_id = "instanceId",
        .last_modified_time = "lastModifiedTime",
        .name = "name",
        .namespace = "namespace",
        .partition_spec = "partitionSpec",
        .schema = "schema",
    };
};
