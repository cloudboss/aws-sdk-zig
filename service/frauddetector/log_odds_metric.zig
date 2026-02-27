/// The log odds metric details.
pub const LogOddsMetric = struct {
    /// The relative importance of the variable. For more information, see [Model
    /// variable
    /// importance](https://docs.aws.amazon.com/frauddetector/latest/ug/model-variable-importance.html).
    variable_importance: f32,

    /// The name of the variable.
    variable_name: []const u8,

    /// The type of variable.
    variable_type: []const u8,

    pub const json_field_names = .{
        .variable_importance = "variableImportance",
        .variable_name = "variableName",
        .variable_type = "variableType",
    };
};
