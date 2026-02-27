const ModelInfrastructureType = @import("model_infrastructure_type.zig").ModelInfrastructureType;
const RealTimeInferenceConfig = @import("real_time_inference_config.zig").RealTimeInferenceConfig;

/// The configuration for the infrastructure that the model will be deployed to.
pub const ModelInfrastructureConfig = struct {
    /// The inference option to which to deploy your model. Possible values are the
    /// following:
    ///
    /// * `RealTime`: Deploy to real-time inference.
    infrastructure_type: ModelInfrastructureType,

    /// The infrastructure configuration for deploying the model to real-time
    /// inference.
    real_time_inference_config: RealTimeInferenceConfig,

    pub const json_field_names = .{
        .infrastructure_type = "InfrastructureType",
        .real_time_inference_config = "RealTimeInferenceConfig",
    };
};
