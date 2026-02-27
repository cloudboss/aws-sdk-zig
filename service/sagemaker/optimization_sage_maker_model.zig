/// A SageMaker model to use as the source or destination for an optimization
/// job.
pub const OptimizationSageMakerModel = struct {
    /// The name of a SageMaker model.
    model_name: ?[]const u8,

    pub const json_field_names = .{
        .model_name = "ModelName",
    };
};
