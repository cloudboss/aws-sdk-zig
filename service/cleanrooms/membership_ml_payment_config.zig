const MembershipModelInferencePaymentConfig = @import("membership_model_inference_payment_config.zig").MembershipModelInferencePaymentConfig;
const MembershipModelTrainingPaymentConfig = @import("membership_model_training_payment_config.zig").MembershipModelTrainingPaymentConfig;
const MembershipSyntheticDataGenerationPaymentConfig = @import("membership_synthetic_data_generation_payment_config.zig").MembershipSyntheticDataGenerationPaymentConfig;

/// An object representing the collaboration member's machine learning payment
/// responsibilities set by the collaboration creator.
pub const MembershipMLPaymentConfig = struct {
    /// The payment responsibilities accepted by the member for model inference.
    model_inference: ?MembershipModelInferencePaymentConfig = null,

    /// The payment responsibilities accepted by the member for model training.
    model_training: ?MembershipModelTrainingPaymentConfig = null,

    /// The payment configuration for synthetic data generation for this machine
    /// learning membership.
    synthetic_data_generation: ?MembershipSyntheticDataGenerationPaymentConfig = null,

    pub const json_field_names = .{
        .model_inference = "modelInference",
        .model_training = "modelTraining",
        .synthetic_data_generation = "syntheticDataGeneration",
    };
};
