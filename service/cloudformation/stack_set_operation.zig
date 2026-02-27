const StackSetOperationAction = @import("stack_set_operation_action.zig").StackSetOperationAction;
const DeploymentTargets = @import("deployment_targets.zig").DeploymentTargets;
const StackSetOperationPreferences = @import("stack_set_operation_preferences.zig").StackSetOperationPreferences;
const StackSetDriftDetectionDetails = @import("stack_set_drift_detection_details.zig").StackSetDriftDetectionDetails;
const StackSetOperationStatus = @import("stack_set_operation_status.zig").StackSetOperationStatus;
const StackSetOperationStatusDetails = @import("stack_set_operation_status_details.zig").StackSetOperationStatusDetails;

/// The structure that contains information about a StackSet operation.
pub const StackSetOperation = struct {
    /// The type of StackSet operation: `CREATE`, `UPDATE`, or
    /// `DELETE`. Create and delete operations affect only the specified stack
    /// instances that
    /// are associated with the specified StackSet. Update operations affect both
    /// the StackSet itself, in
    /// addition to *all* associated stack instances.
    action: ?StackSetOperationAction,

    /// The Amazon Resource Name (ARN) of the IAM role used to perform this StackSet
    /// operation.
    ///
    /// Use customized administrator roles to control which users or groups can
    /// manage specific
    /// StackSets within the same administrator account. For more information, see
    /// [Grant self-managed
    /// permissions](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/stacksets-prereqs-self-managed.html) in the *CloudFormation User Guide*.
    administration_role_arn: ?[]const u8,

    /// The time at which the operation was initiated. Note that the creation times
    /// for the stack
    /// set operation might differ from the creation time of the individual stacks
    /// themselves. This is
    /// because CloudFormation needs to perform preparatory work for the operation,
    /// such as dispatching the
    /// work to the requested Regions, before actually creating the first stacks.
    creation_timestamp: ?i64,

    /// The Organizations accounts affected by the stack operation. Valid only if
    /// the
    /// StackSet uses service-managed permissions.
    deployment_targets: ?DeploymentTargets,

    /// The time at which the StackSet operation ended, across all accounts and
    /// Regions specified.
    /// Note that this doesn't necessarily mean that the StackSet operation was
    /// successful, or even
    /// attempted, in each account or Region.
    end_timestamp: ?i64,

    /// The name of the IAM execution role used to create or update the StackSet.
    ///
    /// Use customized execution roles to control which stack resources users and
    /// groups can include
    /// in their StackSets.
    execution_role_name: ?[]const u8,

    /// The unique ID of a StackSet operation.
    operation_id: ?[]const u8,

    /// The preferences for how CloudFormation performs this StackSet operation.
    operation_preferences: ?StackSetOperationPreferences,

    /// For StackSet operations of action type `DELETE`, specifies whether to remove
    /// the
    /// stack instances from the specified StackSet, but doesn't delete the stacks.
    /// You can't
    /// re-associate a retained stack, or add an existing, saved stack to a new
    /// StackSet.
    retain_stacks: ?bool,

    /// Detailed information about the drift status of the StackSet. This includes
    /// information about
    /// drift operations currently being performed on the StackSet.
    ///
    /// This information will only be present for StackSet operations whose `Action`
    /// type
    /// is `DETECT_DRIFT`.
    ///
    /// For more information, see [Performing drift detection on
    /// CloudFormation
    /// StackSets](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/stacksets-drift.html) in the *CloudFormation User Guide*.
    stack_set_drift_detection_details: ?StackSetDriftDetectionDetails,

    /// The ID of the StackSet.
    stack_set_id: ?[]const u8,

    /// The status of the operation.
    ///
    /// * `FAILED`: The operation exceeded the specified failure tolerance. The
    ///   failure
    /// tolerance value that you've set for an operation is applied for each Region
    /// during stack create
    /// and update operations. If the number of failed stacks within a Region
    /// exceeds the failure
    /// tolerance, the status of the operation in the Region is set to `FAILED`.
    /// This in
    /// turn sets the status of the operation as a whole to `FAILED`, and
    /// CloudFormation cancels
    /// the operation in any remaining Regions.
    ///
    /// * `QUEUED`: [Service-managed permissions] For automatic deployments that
    ///   require
    /// a sequence of operations, the operation is queued to be performed. For more
    /// information, see
    /// the [StackSets status
    /// codes](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/stacksets-concepts.html#stackset-status-codes) in the *CloudFormation User Guide*.
    ///
    /// * `RUNNING`: The operation is currently being performed.
    ///
    /// * `STOPPED`: The user has canceled the operation.
    ///
    /// * `STOPPING`: The operation is in the process of stopping, at user
    /// request.
    ///
    /// * `SUCCEEDED`: The operation completed creating or updating all the
    ///   specified
    /// stacks without exceeding the failure tolerance for the operation.
    status: ?StackSetOperationStatus,

    /// Detailed information about the StackSet operation.
    status_details: ?StackSetOperationStatusDetails,

    /// The status of the operation in details.
    status_reason: ?[]const u8,
};
