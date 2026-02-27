const AthenaDatasetDefinition = @import("athena_dataset_definition.zig").AthenaDatasetDefinition;
const DataDistributionType = @import("data_distribution_type.zig").DataDistributionType;
const InputMode = @import("input_mode.zig").InputMode;
const RedshiftDatasetDefinition = @import("redshift_dataset_definition.zig").RedshiftDatasetDefinition;

/// Configuration for Dataset Definition inputs. The Dataset Definition input
/// must specify exactly one of either `AthenaDatasetDefinition` or
/// `RedshiftDatasetDefinition` types.
pub const DatasetDefinition = struct {
    athena_dataset_definition: ?AthenaDatasetDefinition,

    /// Whether the generated dataset is `FullyReplicated` or `ShardedByS3Key`
    /// (default).
    data_distribution_type: ?DataDistributionType,

    /// Whether to use `File` or `Pipe` input mode. In `File` (default) mode, Amazon
    /// SageMaker copies the data from the input source onto the local Amazon
    /// Elastic Block Store (Amazon EBS) volumes before starting your training
    /// algorithm. This is the most commonly used input mode. In `Pipe` mode, Amazon
    /// SageMaker streams input data from the source directly to your algorithm
    /// without using the EBS volume.
    input_mode: ?InputMode,

    /// The local path where you want Amazon SageMaker to download the Dataset
    /// Definition inputs to run a processing job. `LocalPath` is an absolute path
    /// to the input data. This is a required parameter when `AppManaged` is `False`
    /// (default).
    local_path: ?[]const u8,

    redshift_dataset_definition: ?RedshiftDatasetDefinition,

    pub const json_field_names = .{
        .athena_dataset_definition = "AthenaDatasetDefinition",
        .data_distribution_type = "DataDistributionType",
        .input_mode = "InputMode",
        .local_path = "LocalPath",
        .redshift_dataset_definition = "RedshiftDatasetDefinition",
    };
};
