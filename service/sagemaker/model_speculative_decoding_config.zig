const ModelSpeculativeDecodingTechnique = @import("model_speculative_decoding_technique.zig").ModelSpeculativeDecodingTechnique;
const ModelSpeculativeDecodingTrainingDataSource = @import("model_speculative_decoding_training_data_source.zig").ModelSpeculativeDecodingTrainingDataSource;

/// Settings for the model speculative decoding technique that's applied by a
/// model optimization job.
pub const ModelSpeculativeDecodingConfig = struct {
    /// The speculative decoding technique to apply during model optimization.
    technique: ModelSpeculativeDecodingTechnique,

    /// The location of the training data to use for speculative decoding. The data
    /// must be formatted as ShareGPT, OpenAI Completions or OpenAI Chat
    /// Completions. The input can also be unencrypted captured data from a
    /// SageMaker endpoint as long as the endpoint uses one of the above formats.
    training_data_source: ?ModelSpeculativeDecodingTrainingDataSource,

    pub const json_field_names = .{
        .technique = "Technique",
        .training_data_source = "TrainingDataSource",
    };
};
