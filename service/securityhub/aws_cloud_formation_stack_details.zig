const AwsCloudFormationStackDriftInformationDetails = @import("aws_cloud_formation_stack_drift_information_details.zig").AwsCloudFormationStackDriftInformationDetails;
const AwsCloudFormationStackOutputsDetails = @import("aws_cloud_formation_stack_outputs_details.zig").AwsCloudFormationStackOutputsDetails;

/// Nests a stack as a resource in a top-level template. Nested stacks are
/// stacks created as resources for
/// another stack.
pub const AwsCloudFormationStackDetails = struct {
    /// The capabilities allowed in the stack.
    capabilities: ?[]const []const u8 = null,

    /// The time at which the stack was created.
    creation_time: ?[]const u8 = null,

    /// A user-defined description associated with the stack.
    description: ?[]const u8 = null,

    /// Boolean to enable or disable rollback on stack creation failures.
    disable_rollback: ?bool = null,

    /// Information about whether a stack's actual configuration differs, or has
    /// drifted, from its expected
    /// configuration, as defined in the stack template and any values specified as
    /// template parameters.
    drift_information: ?AwsCloudFormationStackDriftInformationDetails = null,

    /// Whether termination protection is enabled for the stack.
    enable_termination_protection: ?bool = null,

    /// The time the nested stack was last updated. This field will only be returned
    /// if the stack has been
    /// updated at least once.
    last_updated_time: ?[]const u8 = null,

    /// The Amazon Resource Names (ARNs) of the Amazon SNS topic to which
    /// stack-related events are published.
    notification_arns: ?[]const []const u8 = null,

    /// A list of output structures.
    outputs: ?[]const AwsCloudFormationStackOutputsDetails = null,

    /// The ARN of an IAM role that's associated with the stack.
    role_arn: ?[]const u8 = null,

    /// Unique identifier of the stack.
    stack_id: ?[]const u8 = null,

    /// The name associated with the stack.
    stack_name: ?[]const u8 = null,

    /// Current status of the stack.
    stack_status: ?[]const u8 = null,

    /// Success or failure message associated with the stack status.
    stack_status_reason: ?[]const u8 = null,

    /// The length of time, in minutes, that CloudFormation waits for the nested
    /// stack to reach
    /// the `CREATE_COMPLETE` state.
    timeout_in_minutes: ?i32 = null,

    pub const json_field_names = .{
        .capabilities = "Capabilities",
        .creation_time = "CreationTime",
        .description = "Description",
        .disable_rollback = "DisableRollback",
        .drift_information = "DriftInformation",
        .enable_termination_protection = "EnableTerminationProtection",
        .last_updated_time = "LastUpdatedTime",
        .notification_arns = "NotificationArns",
        .outputs = "Outputs",
        .role_arn = "RoleArn",
        .stack_id = "StackId",
        .stack_name = "StackName",
        .stack_status = "StackStatus",
        .stack_status_reason = "StackStatusReason",
        .timeout_in_minutes = "TimeoutInMinutes",
    };
};
