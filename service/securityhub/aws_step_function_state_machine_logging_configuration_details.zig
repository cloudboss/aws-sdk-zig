const AwsStepFunctionStateMachineLoggingConfigurationDestinationsDetails = @import("aws_step_function_state_machine_logging_configuration_destinations_details.zig").AwsStepFunctionStateMachineLoggingConfigurationDestinationsDetails;

/// The `LoggingConfiguration` data type is used to set CloudWatch Logs options.
pub const AwsStepFunctionStateMachineLoggingConfigurationDetails = struct {
    /// An array of objects that describes where your execution history events will
    /// be logged.
    destinations: ?[]const AwsStepFunctionStateMachineLoggingConfigurationDestinationsDetails = null,

    /// Determines whether execution data is included in your log. When set to
    /// false, data is excluded.
    include_execution_data: ?bool = null,

    /// Defines which category of execution history events are logged.
    level: ?[]const u8 = null,

    pub const json_field_names = .{
        .destinations = "Destinations",
        .include_execution_data = "IncludeExecutionData",
        .level = "Level",
    };
};
