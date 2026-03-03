const StackDriftInformationSummary = @import("stack_drift_information_summary.zig").StackDriftInformationSummary;
const OperationEntry = @import("operation_entry.zig").OperationEntry;
const StackStatus = @import("stack_status.zig").StackStatus;

/// The `StackSummary` Data Type
pub const StackSummary = struct {
    /// The time the stack was created.
    creation_time: i64,

    /// The time the stack was deleted.
    deletion_time: ?i64 = null,

    /// Summarizes information about whether a stack's actual configuration differs,
    /// or has
    /// *drifted*, from its expected configuration, as defined in the stack template
    /// and any values specified as template parameters. For more information, see
    /// [Detect
    /// unmanaged configuration changes to stacks and resources with drift
    /// detection](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-cfn-stack-drift.html).
    drift_information: ?StackDriftInformationSummary = null,

    /// Information about the most recent operations performed on this stack.
    last_operations: ?[]const OperationEntry = null,

    /// The time the stack was last updated. This field will only be returned if the
    /// stack has been
    /// updated at least once.
    last_updated_time: ?i64 = null,

    /// For nested stacks, the stack ID of the direct parent of this stack. For the
    /// first level of
    /// nested stacks, the root stack is also the parent stack.
    ///
    /// For more information, see [Nested
    /// stacks](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-cfn-nested-stacks.html) in
    /// the *CloudFormation User Guide*.
    parent_id: ?[]const u8 = null,

    /// For nested stacks, the stack ID of the top-level stack to which the nested
    /// stack ultimately
    /// belongs.
    ///
    /// For more information, see [Nested
    /// stacks](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-cfn-nested-stacks.html) in
    /// the *CloudFormation User Guide*.
    root_id: ?[]const u8 = null,

    /// Unique stack identifier.
    stack_id: ?[]const u8 = null,

    /// The name associated with the stack.
    stack_name: []const u8,

    /// The current status of the stack.
    stack_status: StackStatus,

    /// Success/Failure message associated with the stack status.
    stack_status_reason: ?[]const u8 = null,

    /// The template description of the template used to create the stack.
    template_description: ?[]const u8 = null,
};
