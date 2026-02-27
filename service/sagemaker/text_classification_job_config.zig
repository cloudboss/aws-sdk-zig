const AutoMLJobCompletionCriteria = @import("auto_ml_job_completion_criteria.zig").AutoMLJobCompletionCriteria;

/// The collection of settings used by an AutoML job V2 for the text
/// classification problem type.
pub const TextClassificationJobConfig = struct {
    /// How long a job is allowed to run, or how many candidates a job is allowed to
    /// generate.
    completion_criteria: ?AutoMLJobCompletionCriteria,

    /// The name of the column used to provide the sentences to be classified. It
    /// should not be the same as the target column.
    content_column: []const u8,

    /// The name of the column used to provide the class labels. It should not be
    /// same as the content column.
    target_label_column: []const u8,

    pub const json_field_names = .{
        .completion_criteria = "CompletionCriteria",
        .content_column = "ContentColumn",
        .target_label_column = "TargetLabelColumn",
    };
};
