const HubAccessConfig = @import("hub_access_config.zig").HubAccessConfig;
const ModelAccessConfig = @import("model_access_config.zig").ModelAccessConfig;
const S3DataDistribution = @import("s3_data_distribution.zig").S3DataDistribution;
const S3DataType = @import("s3_data_type.zig").S3DataType;

/// Describes the S3 data source.
///
/// Your input bucket must be in the same Amazon Web Services region as your
/// training job.
pub const S3DataSource = struct {
    /// A list of one or more attribute names to use that are found in a specified
    /// augmented manifest file.
    attribute_names: ?[]const []const u8,

    /// The configuration for a private hub model reference that points to a
    /// SageMaker JumpStart public hub model.
    hub_access_config: ?HubAccessConfig,

    /// A list of names of instance groups that get data from the S3 data source.
    instance_group_names: ?[]const []const u8,

    model_access_config: ?ModelAccessConfig,

    /// If you want SageMaker to replicate the entire dataset on each ML compute
    /// instance that is launched for model training, specify `FullyReplicated`.
    ///
    /// If you want SageMaker to replicate a subset of data on each ML compute
    /// instance that is launched for model training, specify `ShardedByS3Key`. If
    /// there are *n* ML compute instances launched for a training job, each
    /// instance gets approximately 1/*n* of the number of S3 objects. In this case,
    /// model training on each machine uses only the subset of training data.
    ///
    /// Don't choose more ML compute instances for training than available S3
    /// objects. If you do, some nodes won't get any data and you will pay for nodes
    /// that aren't getting any training data. This applies in both File and Pipe
    /// modes. Keep this in mind when developing algorithms.
    ///
    /// In distributed training, where you use multiple ML compute EC2 instances,
    /// you might choose `ShardedByS3Key`. If the algorithm requires copying
    /// training data to the ML storage volume (when `TrainingInputMode` is set to
    /// `File`), this copies 1/*n* of the number of objects.
    s3_data_distribution_type: ?S3DataDistribution,

    /// If you choose `S3Prefix`, `S3Uri` identifies a key name prefix. SageMaker
    /// uses all objects that match the specified key name prefix for model
    /// training.
    ///
    /// If you choose `ManifestFile`, `S3Uri` identifies an object that is a
    /// manifest file containing a list of object keys that you want SageMaker to
    /// use for model training.
    ///
    /// If you choose `AugmentedManifestFile`, `S3Uri` identifies an object that is
    /// an augmented manifest file in JSON lines format. This file contains the data
    /// you want to use for model training. `AugmentedManifestFile` can only be used
    /// if the Channel's input mode is `Pipe`.
    ///
    /// If you choose `Converse`, `S3Uri` identifies an Amazon S3 location that
    /// contains data formatted according to Converse format. This format structures
    /// conversational messages with specific roles and content types used for
    /// training and fine-tuning foundational models.
    s3_data_type: S3DataType,

    /// Depending on the value specified for the `S3DataType`, identifies either a
    /// key name prefix or a manifest. For example:
    ///
    /// * A key name prefix might look like this: `s3://bucketname/exampleprefix/`
    /// * A manifest might look like this: `s3://bucketname/example.manifest`
    ///
    /// A manifest is an S3 object which is a JSON file consisting of an array of
    /// elements. The first element is a prefix which is followed by one or more
    /// suffixes. SageMaker appends the suffix elements to the prefix to get a full
    /// set of `S3Uri`. Note that the prefix must be a valid non-empty `S3Uri` that
    /// precludes users from specifying a manifest whose individual `S3Uri` is
    /// sourced from different S3 buckets.
    ///
    /// The following code example shows a valid manifest format:
    ///
    /// `[ {"prefix": "s3://customer_bucket/some/prefix/"},`
    ///
    /// ` "relative/path/to/custdata-1",`
    ///
    /// ` "relative/path/custdata-2",`
    ///
    /// ` ...`
    ///
    /// ` "relative/path/custdata-N"`
    ///
    /// `]`
    ///
    /// This JSON is equivalent to the following `S3Uri` list:
    ///
    /// `s3://customer_bucket/some/prefix/relative/path/to/custdata-1`
    ///
    /// `s3://customer_bucket/some/prefix/relative/path/custdata-2`
    ///
    /// `...`
    ///
    /// `s3://customer_bucket/some/prefix/relative/path/custdata-N`
    ///
    /// The complete set of `S3Uri` in this manifest is the input data for the
    /// channel for this data source. The object that each `S3Uri` points to must be
    /// readable by the IAM role that SageMaker uses to perform tasks on your
    /// behalf.
    ///
    /// Your input bucket must be located in same Amazon Web Services region as your
    /// training job.
    s3_uri: []const u8,

    pub const json_field_names = .{
        .attribute_names = "AttributeNames",
        .hub_access_config = "HubAccessConfig",
        .instance_group_names = "InstanceGroupNames",
        .model_access_config = "ModelAccessConfig",
        .s3_data_distribution_type = "S3DataDistributionType",
        .s3_data_type = "S3DataType",
        .s3_uri = "S3Uri",
    };
};
