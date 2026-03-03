const ModelInputDataFormat = @import("model_input_data_format.zig").ModelInputDataFormat;

/// The Amazon SageMaker model input configuration.
pub const ModelInputConfiguration = struct {
    /// Template for constructing the CSV input-data sent to SageMaker. At
    /// event-evaluation,
    /// the placeholders for variable-names in the template will be replaced with
    /// the variable
    /// values before being sent to SageMaker.
    csv_input_template: ?[]const u8 = null,

    /// The event type name.
    event_type_name: ?[]const u8 = null,

    /// The format of the model input configuration. The format differs depending on
    /// if it is
    /// passed through to SageMaker or constructed by Amazon Fraud Detector.
    format: ?ModelInputDataFormat = null,

    /// Template for constructing the JSON input-data sent to SageMaker. At
    /// event-evaluation,
    /// the placeholders for variable names in the template will be replaced with
    /// the variable
    /// values before being sent to SageMaker.
    json_input_template: ?[]const u8 = null,

    /// The event variables.
    use_event_variables: bool,

    pub const json_field_names = .{
        .csv_input_template = "csvInputTemplate",
        .event_type_name = "eventTypeName",
        .format = "format",
        .json_input_template = "jsonInputTemplate",
        .use_event_variables = "useEventVariables",
    };
};
