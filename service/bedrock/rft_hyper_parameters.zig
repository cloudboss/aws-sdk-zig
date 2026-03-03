const ReasoningEffort = @import("reasoning_effort.zig").ReasoningEffort;

/// Hyperparameters for controlling the reinforcement fine-tuning training
/// process, including learning settings and evaluation intervals.
pub const RFTHyperParameters = struct {
    /// Number of training samples processed in each batch during reinforcement
    /// fine-tuning (RFT) training. Larger batches may improve training stability.
    batch_size: ?i32 = null,

    /// Number of training epochs to run during reinforcement fine-tuning. Higher
    /// values may improve performance but increase training time.
    epoch_count: ?i32 = null,

    /// Interval between evaluation runs during RFT training, measured in training
    /// steps. More frequent evaluation provides better monitoring.
    eval_interval: ?i32 = null,

    /// Maximum number of tokens the model can generate in response to each prompt
    /// during RFT training.
    inference_max_tokens: ?i32 = null,

    /// Learning rate for the reinforcement fine-tuning. Controls how quickly the
    /// model adapts to reward signals.
    learning_rate: ?f32 = null,

    /// Maximum length of input prompts during RFT training, measured in tokens.
    /// Longer prompts allow more context but increase memory usage and
    /// training-time.
    max_prompt_length: ?i32 = null,

    /// Level of reasoning effort applied during RFT training. Higher values may
    /// improve response quality but increase training time.
    reasoning_effort: ?ReasoningEffort = null,

    /// Number of response samples generated per prompt during RFT training. More
    /// samples provide better reward signal estimation.
    training_sample_per_prompt: ?i32 = null,

    pub const json_field_names = .{
        .batch_size = "batchSize",
        .epoch_count = "epochCount",
        .eval_interval = "evalInterval",
        .inference_max_tokens = "inferenceMaxTokens",
        .learning_rate = "learningRate",
        .max_prompt_length = "maxPromptLength",
        .reasoning_effort = "reasoningEffort",
        .training_sample_per_prompt = "trainingSamplePerPrompt",
    };
};
