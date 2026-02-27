const aws = @import("aws");

/// The details of the external (Amazon Sagemaker) model evaluated for
/// generating predictions.
pub const EvaluatedExternalModel = struct {
    /// Input variables use for generating predictions.
    input_variables: ?[]const aws.map.StringMapEntry,

    /// The endpoint of the external (Amazon Sagemaker) model.
    model_endpoint: ?[]const u8,

    /// Output variables.
    output_variables: ?[]const aws.map.StringMapEntry,

    /// Indicates whether event variables were used to generate predictions.
    use_event_variables: ?bool,

    pub const json_field_names = .{
        .input_variables = "inputVariables",
        .model_endpoint = "modelEndpoint",
        .output_variables = "outputVariables",
        .use_event_variables = "useEventVariables",
    };
};
