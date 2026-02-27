const OptimizationModelAccessConfig = @import("optimization_model_access_config.zig").OptimizationModelAccessConfig;

/// The Amazon S3 location of a source model to optimize with an optimization
/// job.
pub const OptimizationJobModelSourceS3 = struct {
    /// The access configuration settings for the source ML model for an
    /// optimization job, where you can accept the model end-user license agreement
    /// (EULA).
    model_access_config: ?OptimizationModelAccessConfig,

    /// An Amazon S3 URI that locates a source model to optimize with an
    /// optimization job.
    s3_uri: ?[]const u8,

    pub const json_field_names = .{
        .model_access_config = "ModelAccessConfig",
        .s3_uri = "S3Uri",
    };
};
