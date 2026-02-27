const ModelDataSource = @import("model_data_source.zig").ModelDataSource;

/// Specifies an algorithm that was used to create the model package. The
/// algorithm must be either an algorithm resource in your SageMaker account or
/// an algorithm in Amazon Web Services Marketplace that you are subscribed to.
pub const SourceAlgorithm = struct {
    /// The name of an algorithm that was used to create the model package. The
    /// algorithm must be either an algorithm resource in your SageMaker account or
    /// an algorithm in Amazon Web Services Marketplace that you are subscribed to.
    algorithm_name: []const u8,

    /// The ETag associated with Model Data URL.
    model_data_e_tag: ?[]const u8,

    /// Specifies the location of ML model data to deploy during endpoint creation.
    model_data_source: ?ModelDataSource,

    /// The Amazon S3 path where the model artifacts, which result from model
    /// training, are stored. This path must point to a single `gzip` compressed tar
    /// archive (`.tar.gz` suffix).
    ///
    /// The model artifacts must be in an S3 bucket that is in the same Amazon Web
    /// Services region as the algorithm.
    model_data_url: ?[]const u8,

    pub const json_field_names = .{
        .algorithm_name = "AlgorithmName",
        .model_data_e_tag = "ModelDataETag",
        .model_data_source = "ModelDataSource",
        .model_data_url = "ModelDataUrl",
    };
};
