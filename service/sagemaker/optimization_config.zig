const ModelCompilationConfig = @import("model_compilation_config.zig").ModelCompilationConfig;
const ModelQuantizationConfig = @import("model_quantization_config.zig").ModelQuantizationConfig;
const ModelShardingConfig = @import("model_sharding_config.zig").ModelShardingConfig;
const ModelSpeculativeDecodingConfig = @import("model_speculative_decoding_config.zig").ModelSpeculativeDecodingConfig;

/// Settings for an optimization technique that you apply with a model
/// optimization job.
pub const OptimizationConfig = union(enum) {
    /// Settings for the model compilation technique that's applied by a model
    /// optimization job.
    model_compilation_config: ?ModelCompilationConfig,
    /// Settings for the model quantization technique that's applied by a model
    /// optimization job.
    model_quantization_config: ?ModelQuantizationConfig,
    /// Settings for the model sharding technique that's applied by a model
    /// optimization job.
    model_sharding_config: ?ModelShardingConfig,
    /// Settings for the model speculative decoding technique that's applied by a
    /// model optimization job.
    model_speculative_decoding_config: ?ModelSpeculativeDecodingConfig,

    pub const json_field_names = .{
        .model_compilation_config = "ModelCompilationConfig",
        .model_quantization_config = "ModelQuantizationConfig",
        .model_sharding_config = "ModelShardingConfig",
        .model_speculative_decoding_config = "ModelSpeculativeDecodingConfig",
    };
};
