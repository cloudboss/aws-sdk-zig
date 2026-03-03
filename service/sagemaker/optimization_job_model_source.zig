const OptimizationJobModelSourceS3 = @import("optimization_job_model_source_s3.zig").OptimizationJobModelSourceS3;
const OptimizationSageMakerModel = @import("optimization_sage_maker_model.zig").OptimizationSageMakerModel;

/// The location of the source model to optimize with an optimization job.
pub const OptimizationJobModelSource = struct {
    /// The Amazon S3 location of a source model to optimize with an optimization
    /// job.
    s3: ?OptimizationJobModelSourceS3 = null,

    /// The name of an existing SageMaker model to optimize with an optimization
    /// job.
    sage_maker_model: ?OptimizationSageMakerModel = null,

    pub const json_field_names = .{
        .s3 = "S3",
        .sage_maker_model = "SageMakerModel",
    };
};
