const OptimizationSageMakerModel = @import("optimization_sage_maker_model.zig").OptimizationSageMakerModel;

/// Details for where to store the optimized model that you create with the
/// optimization job.
pub const OptimizationJobOutputConfig = struct {
    /// The Amazon Resource Name (ARN) of a key in Amazon Web Services KMS.
    /// SageMaker uses they key to encrypt the artifacts of the optimized model when
    /// SageMaker uploads the model to Amazon S3.
    kms_key_id: ?[]const u8 = null,

    /// The Amazon S3 URI for where to store the optimized model that you create
    /// with an optimization job.
    s3_output_location: []const u8,

    /// The name of a SageMaker model to use as the output destination for an
    /// optimization job.
    sage_maker_model: ?OptimizationSageMakerModel = null,

    pub const json_field_names = .{
        .kms_key_id = "KmsKeyId",
        .s3_output_location = "S3OutputLocation",
        .sage_maker_model = "SageMakerModel",
    };
};
