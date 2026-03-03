/// Configuration for tool output handling.
pub const ToolOutputConfiguration = struct {
    /// Override the tool output results to different variable name.
    output_variable_name_override: ?[]const u8 = null,

    /// The session data namespace for tool output.
    session_data_namespace: ?[]const u8 = null,

    pub const json_field_names = .{
        .output_variable_name_override = "outputVariableNameOverride",
        .session_data_namespace = "sessionDataNamespace",
    };
};
