/// Contains the configuration of the type of anomaly detection computation
/// model.
pub const ComputationModelAnomalyDetectionConfiguration = struct {
    /// Define the variable name associated with input properties, with the
    /// following format
    /// `${VariableName}`.
    input_properties: []const u8,

    /// Define the variable name associated with the result property, and the
    /// following format
    /// `${VariableName}`.
    result_property: []const u8,

    pub const json_field_names = .{
        .input_properties = "inputProperties",
        .result_property = "resultProperty",
    };
};
