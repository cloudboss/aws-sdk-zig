const GraderConfig = @import("grader_config.zig").GraderConfig;
const RFTHyperParameters = @import("rft_hyper_parameters.zig").RFTHyperParameters;

/// Configuration settings for reinforcement fine-tuning (RFT), including grader
/// configuration and training hyperparameters.
pub const RFTConfig = struct {
    /// Configuration for the grader that evaluates model responses and provides
    /// reward signals during RFT training.
    grader_config: ?GraderConfig,

    /// Hyperparameters that control the reinforcement fine-tuning training process,
    /// including learning rate, batch size, and epoch count.
    hyper_parameters: ?RFTHyperParameters,

    pub const json_field_names = .{
        .grader_config = "graderConfig",
        .hyper_parameters = "hyperParameters",
    };
};
