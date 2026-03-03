const StackSetOperationAction = @import("stack_set_operation_action.zig").StackSetOperationAction;
const StackSetOperationPreferences = @import("stack_set_operation_preferences.zig").StackSetOperationPreferences;
const StackSetOperationStatus = @import("stack_set_operation_status.zig").StackSetOperationStatus;
const StackSetOperationStatusDetails = @import("stack_set_operation_status_details.zig").StackSetOperationStatusDetails;

/// The structures that contain summary information about the specified
/// operation.
pub const StackSetOperationSummary = struct {
    /// The type of operation: `CREATE`, `UPDATE`, or `DELETE`.
    /// Create and delete operations affect only the specified stack instances that
    /// are associated with
    /// the specified StackSet. Update operations affect both the StackSet itself
    /// and
    /// *all* associated StackSet instances.
    action: ?StackSetOperationAction = null,

    /// The time at which the operation was initiated. Note that the creation times
    /// for the StackSet
    /// operation might differ from the creation time of the individual stacks
    /// themselves. This is
    /// because CloudFormation needs to perform preparatory work for the operation,
    /// such as dispatching the
    /// work to the requested Regions, before actually creating the first stacks.
    creation_timestamp: ?i64 = null,

    /// The time at which the StackSet operation ended, across all accounts and
    /// Regions specified.
    /// Note that this doesn't necessarily mean that the StackSet operation was
    /// successful, or even
    /// attempted, in each account or Region.
    end_timestamp: ?i64 = null,

    /// The unique ID of the StackSet operation.
    operation_id: ?[]const u8 = null,

    /// The user-specified preferences for how CloudFormation performs a StackSet
    /// operation.
    ///
    /// For more information about maximum concurrent accounts and failure
    /// tolerance, see [StackSet
    /// operation
    /// options](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/stacksets-concepts.html#stackset-ops-options).
    operation_preferences: ?StackSetOperationPreferences = null,

    /// The overall status of the operation.
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
    /// the [StackSet status
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
    status: ?StackSetOperationStatus = null,

    /// Detailed information about the StackSet operation.
    status_details: ?StackSetOperationStatusDetails = null,

    /// The status of the operation in details.
    status_reason: ?[]const u8 = null,
};
