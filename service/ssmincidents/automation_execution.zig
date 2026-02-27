/// The Systems Manager automation document process to start as the runbook at
/// the
/// beginning of the incident.
pub const AutomationExecution = union(enum) {
    /// The Amazon Resource Name (ARN) of the automation process.
    ssm_execution_arn: ?[]const u8,

    pub const json_field_names = .{
        .ssm_execution_arn = "ssmExecutionArn",
    };
};
