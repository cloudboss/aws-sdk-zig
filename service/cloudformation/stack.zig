const Capability = @import("capability.zig").Capability;
const DeletionMode = @import("deletion_mode.zig").DeletionMode;
const DetailedStatus = @import("detailed_status.zig").DetailedStatus;
const StackDriftInformation = @import("stack_drift_information.zig").StackDriftInformation;
const OperationEntry = @import("operation_entry.zig").OperationEntry;
const Output = @import("output.zig").Output;
const Parameter = @import("parameter.zig").Parameter;
const RollbackConfiguration = @import("rollback_configuration.zig").RollbackConfiguration;
const StackStatus = @import("stack_status.zig").StackStatus;
const Tag = @import("tag.zig").Tag;

/// The `Stack` data type.
pub const Stack = struct {
    /// The capabilities allowed in the stack.
    capabilities: ?[]const Capability = null,

    /// The unique ID of the change set.
    change_set_id: ?[]const u8 = null,

    /// The time at which the stack was created.
    creation_time: i64,

    /// Specifies the deletion mode for the stack. Possible values are:
    ///
    /// * `STANDARD` - Use the standard behavior. Specifying this value is the same
    ///   as
    /// not specifying this parameter.
    ///
    /// * `FORCE_DELETE_STACK` - Delete the stack if it's stuck in a
    /// `DELETE_FAILED` state due to resource deletion failure.
    deletion_mode: ?DeletionMode = null,

    /// The time the stack was deleted.
    deletion_time: ?i64 = null,

    /// A user-defined description associated with the stack.
    description: ?[]const u8 = null,

    /// The detailed status of the resource or stack. If `CONFIGURATION_COMPLETE` is
    /// present, the resource or resource configuration phase has completed and the
    /// stabilization of the
    /// resources is in progress. The StackSets `CONFIGURATION_COMPLETE` when all of
    /// the
    /// resources in the stack have reached that event. For more information, see
    /// [Understand
    /// CloudFormation stack creation
    /// events](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/stack-resource-configuration-complete.html) in the *CloudFormation User Guide*.
    detailed_status: ?DetailedStatus = null,

    /// Boolean to enable or disable rollback on stack creation failures:
    ///
    /// * `true`: disable rollback.
    ///
    /// * `false`: enable rollback.
    disable_rollback: ?bool = null,

    /// Information about whether a stack's actual configuration differs, or has
    /// *drifted*, from its expected configuration, as defined in the stack template
    /// and any values specified as template parameters. For more information, see
    /// [Detect
    /// unmanaged configuration changes to stacks and resources with drift
    /// detection](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-cfn-stack-drift.html).
    drift_information: ?StackDriftInformation = null,

    /// Whether termination protection is enabled for the stack.
    ///
    /// For [nested
    /// stacks](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-cfn-nested-stacks.html),
    /// termination protection is set on the root stack and can't be changed
    /// directly on the nested
    /// stack. For more information, see [Protect a CloudFormation
    /// stack from being
    /// deleted](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-cfn-protect-stacks.html) in the *CloudFormation User Guide*.
    enable_termination_protection: ?bool = null,

    /// Information about the most recent operations performed on this stack.
    last_operations: ?[]const OperationEntry = null,

    /// The time the stack was last updated. This field will only be returned if the
    /// stack has been
    /// updated at least once.
    last_updated_time: ?i64 = null,

    /// Amazon SNS topic Amazon Resource Names (ARNs) to which stack related events
    /// are published.
    notification_ar_ns: ?[]const []const u8 = null,

    /// A list of output structures.
    outputs: ?[]const Output = null,

    /// A list of `Parameter` structures.
    parameters: ?[]const Parameter = null,

    /// For nested stacks, the stack ID of the direct parent of this stack. For the
    /// first level of
    /// nested stacks, the root stack is also the parent stack.
    ///
    /// For more information, see [Nested
    /// stacks](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-cfn-nested-stacks.html) in
    /// the *CloudFormation User Guide*.
    parent_id: ?[]const u8 = null,

    /// When set to `true`, newly created resources are deleted when the operation
    /// rolls
    /// back. This includes newly created resources marked with a deletion policy of
    /// `Retain`.
    ///
    /// Default: `false`
    retain_except_on_create: ?bool = null,

    /// The Amazon Resource Name (ARN) of an IAM role that's associated with the
    /// stack. During a
    /// stack operation, CloudFormation uses this role's credentials to make calls
    /// on your behalf.
    role_arn: ?[]const u8 = null,

    /// The rollback triggers for CloudFormation to monitor during stack creation
    /// and updating
    /// operations, and for the specified monitoring period afterwards.
    rollback_configuration: ?RollbackConfiguration = null,

    /// For nested stacks, the stack ID of the top-level stack to which the nested
    /// stack ultimately
    /// belongs.
    ///
    /// For more information, see [Nested
    /// stacks](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-cfn-nested-stacks.html) in
    /// the *CloudFormation User Guide*.
    root_id: ?[]const u8 = null,

    /// Unique identifier of the stack.
    stack_id: ?[]const u8 = null,

    /// The name associated with the stack.
    stack_name: []const u8,

    /// Current status of the stack.
    stack_status: StackStatus,

    /// Success/failure message associated with the stack status.
    stack_status_reason: ?[]const u8 = null,

    /// A list of `Tag`s that specify information about the stack.
    tags: ?[]const Tag = null,

    /// The amount of time within which stack creation should complete.
    timeout_in_minutes: ?i32 = null,
};
