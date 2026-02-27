/// A summary of a model used for a model evaluation job where you provide your
/// own inference response data.
pub const EvaluationPrecomputedInferenceSource = struct {
    /// A label that identifies a model used in a model evaluation job where you
    /// provide your own inference response data.
    inference_source_identifier: []const u8,

    pub const json_field_names = .{
        .inference_source_identifier = "inferenceSourceIdentifier",
    };
};
