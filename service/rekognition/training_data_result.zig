const TrainingData = @import("training_data.zig").TrainingData;
const ValidationData = @import("validation_data.zig").ValidationData;

/// The data
/// validation manifest created for the training dataset during model training.
pub const TrainingDataResult = struct {
    /// The training data that you supplied.
    input: ?TrainingData,

    /// Reference to images (assets) that were actually used during training with
    /// trained model
    /// predictions.
    output: ?TrainingData,

    /// A manifest that you supplied for training, with validation results for each
    /// line.
    validation: ?ValidationData,

    pub const json_field_names = .{
        .input = "Input",
        .output = "Output",
        .validation = "Validation",
    };
};
