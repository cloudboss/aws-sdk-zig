const DistillationConfig = @import("distillation_config.zig").DistillationConfig;
const RFTConfig = @import("rft_config.zig").RFTConfig;

/// A model customization configuration
pub const CustomizationConfig = union(enum) {
    /// The Distillation configuration for the custom model.
    distillation_config: ?DistillationConfig,
    /// Configuration settings for reinforcement fine-tuning (RFT) model
    /// customization, including grader configuration and hyperparameters.
    rft_config: ?RFTConfig,

    pub const json_field_names = .{
        .distillation_config = "distillationConfig",
        .rft_config = "rftConfig",
    };
};
