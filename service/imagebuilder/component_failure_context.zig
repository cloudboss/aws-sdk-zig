/// Contains details about the component that caused the image creation process
/// to
/// fail. The details identify the first step that failed when the component
/// ran.
pub const ComponentFailureContext = struct {
    /// The action that the failed step runs, for example `ExecuteBash`.
    action: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the component build version that failed.
    component_arn: ?[]const u8 = null,

    /// The error message from the step that failed. Image Builder truncates
    /// messages that are
    /// longer than 1024 characters. The component log in Amazon CloudWatch Logs
    /// contains
    /// the full output.
    error_message: ?[]const u8 = null,

    /// The name of the phase in the component document where the failure occurred,
    /// such
    /// as `build`, `validate`, or `test`.
    phase_name: ?[]const u8 = null,

    /// The name of the step in the component document that failed.
    step_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .action = "action",
        .component_arn = "componentArn",
        .error_message = "errorMessage",
        .phase_name = "phaseName",
        .step_name = "stepName",
    };
};
