/// Contains the Amazon S3 location of the training data you want to use to
/// create
/// a new custom language model, and permissions to access this location.
///
/// When using `InputDataConfig`, you must include these sub-parameters:
/// `S3Uri` and `DataAccessRoleArn`. You can optionally include
/// `TuningDataS3Uri`.
pub const InputDataConfig = struct {
    /// The Amazon Resource Name (ARN) of an IAM role that has permissions to
    /// access the Amazon S3 bucket that contains your input files. If the role that
    /// you
    /// specify doesn’t have the appropriate permissions to access the specified
    /// Amazon S3
    /// location, your request fails.
    ///
    /// IAM role ARNs have the format
    /// `arn:partition:iam::account:role/role-name-with-path`. For example:
    /// `arn:aws:iam::111122223333:role/Admin`.
    ///
    /// For more information, see [IAM
    /// ARNs](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_identifiers.html#identifiers-arns).
    data_access_role_arn: []const u8,

    /// The Amazon S3 location (URI) of the text files you want to use to train your
    /// custom language model.
    ///
    /// Here's an example URI path:
    /// `s3://DOC-EXAMPLE-BUCKET/my-model-training-data/`
    s3_uri: []const u8,

    /// The Amazon S3 location (URI) of the text files you want to use to tune your
    /// custom language model.
    ///
    /// Here's an example URI path:
    /// `s3://DOC-EXAMPLE-BUCKET/my-model-tuning-data/`
    tuning_data_s3_uri: ?[]const u8,

    pub const json_field_names = .{
        .data_access_role_arn = "DataAccessRoleArn",
        .s3_uri = "S3Uri",
        .tuning_data_s3_uri = "TuningDataS3Uri",
    };
};
