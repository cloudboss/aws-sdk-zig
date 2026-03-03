const DataProcessingDetails = @import("data_processing_details.zig").DataProcessingDetails;
const TrainingDetails = @import("training_details.zig").TrainingDetails;
const ValidationDetails = @import("validation_details.zig").ValidationDetails;

/// For a Distillation job, the status details for sub-tasks of the job.
/// Possible statuses for each sub-task include the following:
///
/// * NotStarted
/// * InProgress
/// * Completed
/// * Stopping
/// * Stopped
/// * Failed
pub const StatusDetails = struct {
    /// The status details for the data processing sub-task of the job.
    data_processing_details: ?DataProcessingDetails = null,

    /// The status details for the training sub-task of the job.
    training_details: ?TrainingDetails = null,

    /// The status details for the validation sub-task of the job.
    validation_details: ?ValidationDetails = null,

    pub const json_field_names = .{
        .data_processing_details = "dataProcessingDetails",
        .training_details = "trainingDetails",
        .validation_details = "validationDetails",
    };
};
