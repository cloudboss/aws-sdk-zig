const ModelInferencePaymentConfig = @import("model_inference_payment_config.zig").ModelInferencePaymentConfig;
const ModelTrainingPaymentConfig = @import("model_training_payment_config.zig").ModelTrainingPaymentConfig;
const SyntheticDataGenerationPaymentConfig = @import("synthetic_data_generation_payment_config.zig").SyntheticDataGenerationPaymentConfig;

/// An object representing the collaboration member's machine learning payment
/// responsibilities set by the collaboration creator.
pub const MLPaymentConfig = struct {
    /// The payment responsibilities accepted by the member for model inference.
    model_inference: ?ModelInferencePaymentConfig,

    /// The payment responsibilities accepted by the member for model training.
    model_training: ?ModelTrainingPaymentConfig,

    /// The payment configuration for machine learning synthetic data generation.
    synthetic_data_generation: ?SyntheticDataGenerationPaymentConfig,

    pub const json_field_names = .{
        .model_inference = "modelInference",
        .model_training = "modelTraining",
        .synthetic_data_generation = "syntheticDataGeneration",
    };
};
