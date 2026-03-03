/// Starts execution of a Step Functions state machine.
pub const StepFunctionsAction = struct {
    /// (Optional) A name will be given to the state machine execution consisting of
    /// this
    /// prefix followed by a UUID. Step Functions automatically creates a unique
    /// name for each state
    /// machine execution if one is not provided.
    execution_name_prefix: ?[]const u8 = null,

    /// The ARN of the role that grants IoT permission to start execution of a state
    /// machine
    /// ("Action":"states:StartExecution").
    role_arn: []const u8,

    /// The name of the Step Functions state machine whose execution will be
    /// started.
    state_machine_name: []const u8,

    pub const json_field_names = .{
        .execution_name_prefix = "executionNamePrefix",
        .role_arn = "roleArn",
        .state_machine_name = "stateMachineName",
    };
};
