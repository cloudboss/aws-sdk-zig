const AwsStepFunctionStateMachineLoggingConfigurationDetails = @import("aws_step_function_state_machine_logging_configuration_details.zig").AwsStepFunctionStateMachineLoggingConfigurationDetails;
const AwsStepFunctionStateMachineTracingConfigurationDetails = @import("aws_step_function_state_machine_tracing_configuration_details.zig").AwsStepFunctionStateMachineTracingConfigurationDetails;

/// Provides details about an Step Functions state machine, which is a workflow
/// consisting of a series of event-
/// driven steps.
pub const AwsStepFunctionStateMachineDetails = struct {
    /// A user-defined or an auto-generated string that identifies a `Map` state.
    /// This parameter is present only if
    /// the `stateMachineArn` specified in input is a qualified state machine ARN.
    label: ?[]const u8,

    /// Used to set CloudWatch Logs options.
    logging_configuration: ?AwsStepFunctionStateMachineLoggingConfigurationDetails,

    /// The name of the state machine.
    name: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the IAM role used when creating this state
    /// machine.
    role_arn: ?[]const u8,

    /// The ARN that identifies the state machine.
    state_machine_arn: ?[]const u8,

    /// The current status of the state machine.
    status: ?[]const u8,

    /// Specifies whether X-Ray tracing is enabled.
    tracing_configuration: ?AwsStepFunctionStateMachineTracingConfigurationDetails,

    /// The type of the state machine (STANDARD or EXPRESS).
    type: ?[]const u8,

    pub const json_field_names = .{
        .label = "Label",
        .logging_configuration = "LoggingConfiguration",
        .name = "Name",
        .role_arn = "RoleArn",
        .state_machine_arn = "StateMachineArn",
        .status = "Status",
        .tracing_configuration = "TracingConfiguration",
        .type = "Type",
    };
};
