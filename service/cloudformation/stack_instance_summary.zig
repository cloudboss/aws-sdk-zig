const StackDriftStatus = @import("stack_drift_status.zig").StackDriftStatus;
const StackInstanceComprehensiveStatus = @import("stack_instance_comprehensive_status.zig").StackInstanceComprehensiveStatus;
const StackInstanceStatus = @import("stack_instance_status.zig").StackInstanceStatus;

/// The structure that contains summary information about a stack instance.
pub const StackInstanceSummary = struct {
    /// [Self-managed permissions] The name of the Amazon Web Services account that
    /// the stack instance is
    /// associated with.
    account: ?[]const u8,

    /// Status of the stack instance's actual configuration compared to the expected
    /// template and
    /// parameter configuration of the StackSet it belongs to.
    ///
    /// * `DRIFTED`: The stack differs from the expected template and parameter
    /// configuration of the StackSet it belongs to. A stack instance is considered
    /// to have drifted if
    /// one or more of the resources in the associated stack have drifted.
    ///
    /// * `NOT_CHECKED`: CloudFormation hasn't checked if the stack instance differs
    ///   from its
    /// expected StackSet configuration.
    ///
    /// * `IN_SYNC`: The stack instance's actual configuration matches its expected
    /// StackSet configuration.
    ///
    /// * `UNKNOWN`: This value is reserved for future use.
    drift_status: ?StackDriftStatus,

    /// Most recent time when CloudFormation performed a drift detection operation
    /// on the stack
    /// instance. This value will be `NULL` for any stack instance that drift
    /// detection hasn't
    /// yet been performed on.
    last_drift_check_timestamp: ?i64,

    /// The last unique ID of a StackSet operation performed on a stack instance.
    last_operation_id: ?[]const u8,

    /// [Service-managed permissions] The organization root ID or organizational
    /// unit (OU) IDs that
    /// you specified for
    /// [DeploymentTargets](https://docs.aws.amazon.com/AWSCloudFormation/latest/APIReference/API_DeploymentTargets.html).
    organizational_unit_id: ?[]const u8,

    /// The name of the Amazon Web Services Region that the stack instance is
    /// associated with.
    region: ?[]const u8,

    /// The ID of the stack instance.
    stack_id: ?[]const u8,

    /// The detailed status of the stack instance.
    stack_instance_status: ?StackInstanceComprehensiveStatus,

    /// The name or unique ID of the StackSet that the stack instance is associated
    /// with.
    stack_set_id: ?[]const u8,

    /// The status of the stack instance, in terms of its synchronization with its
    /// associated stack
    /// set.
    ///
    /// * `INOPERABLE`: A `DeleteStackInstances` operation has failed and left
    /// the stack in an unstable state. Stacks in this state are excluded from
    /// further
    /// `UpdateStackSet` operations. You might need to perform a
    /// `DeleteStackInstances` operation, with `RetainStacks` set to
    /// `true`, to delete the stack instance, and then delete the stack manually.
    /// `INOPERABLE` can be returned here when the cause is a failed import. If it's
    /// due to
    /// a failed import, the operation can be retried once the failures are fixed.
    /// To see if this is
    /// due to a failed import, call the DescribeStackInstance API operation, look
    /// at
    /// the `DetailedStatus` member returned in the `StackInstanceSummary`
    /// member.
    ///
    /// * `OUTDATED`: The stack isn't currently up to date with the StackSet
    /// because:
    ///
    /// * The associated stack failed during a `CreateStackSet` or
    /// `UpdateStackSet` operation.
    ///
    /// * The stack was part of a `CreateStackSet` or `UpdateStackSet`
    /// operation that failed or was stopped before the stack was created or
    /// updated.
    ///
    /// * `CURRENT`: The stack is currently up to date with the StackSet.
    status: ?StackInstanceStatus,

    /// The explanation for the specific status code assigned to this stack
    /// instance.
    status_reason: ?[]const u8,
};
