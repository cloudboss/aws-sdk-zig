const aws = @import("aws");

const ExternalModelSummary = @import("external_model_summary.zig").ExternalModelSummary;

/// The fraud prediction scores from Amazon SageMaker model.
pub const ExternalModelOutputs = struct {
    /// The Amazon SageMaker model.
    external_model: ?ExternalModelSummary,

    /// The fraud prediction scores from Amazon SageMaker model.
    outputs: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .external_model = "externalModel",
        .outputs = "outputs",
    };
};
