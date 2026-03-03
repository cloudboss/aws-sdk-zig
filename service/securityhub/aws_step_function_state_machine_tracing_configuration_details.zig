/// Specifies whether X-Ray tracing is enabled.
pub const AwsStepFunctionStateMachineTracingConfigurationDetails = struct {
    /// When set to true, X-Ray tracing is enabled.
    enabled: ?bool = null,

    pub const json_field_names = .{
        .enabled = "Enabled",
    };
};
