const AutoMLJobCompletionCriteria = @import("auto_ml_job_completion_criteria.zig").AutoMLJobCompletionCriteria;

/// The collection of settings used by an AutoML job V2 for the image
/// classification problem type.
pub const ImageClassificationJobConfig = struct {
    /// How long a job is allowed to run, or how many candidates a job is allowed to
    /// generate.
    completion_criteria: ?AutoMLJobCompletionCriteria,

    pub const json_field_names = .{
        .completion_criteria = "CompletionCriteria",
    };
};
