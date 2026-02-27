const StackSetDriftDetectionStatus = @import("stack_set_drift_detection_status.zig").StackSetDriftDetectionStatus;
const StackSetDriftStatus = @import("stack_set_drift_status.zig").StackSetDriftStatus;

/// Detailed information about the drift status of the StackSet.
///
/// For StackSets, contains information about the last *completed* drift
/// operation performed on the StackSet. Information about drift operations
/// in-progress isn't
/// included.
///
/// For StackSet operations, includes information about drift operations
/// currently being
/// performed on the StackSet.
///
/// For more information, see [Performing drift detection on
/// CloudFormation
/// StackSets](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/stacksets-drift.html) in the *CloudFormation User Guide*.
pub const StackSetDriftDetectionDetails = struct {
    /// The status of the StackSet drift detection operation.
    ///
    /// * `COMPLETED`: The drift detection operation completed without failing on
    ///   any
    /// stack instances.
    ///
    /// * `FAILED`: The drift detection operation exceeded the specified failure
    /// tolerance.
    ///
    /// * `PARTIAL_SUCCESS`: The drift detection operation completed without
    ///   exceeding
    /// the failure tolerance for the operation.
    ///
    /// * `IN_PROGRESS`: The drift detection operation is currently being
    /// performed.
    ///
    /// * `STOPPED`: The user has canceled the drift detection operation.
    drift_detection_status: ?StackSetDriftDetectionStatus,

    /// The number of stack instances that have drifted from the expected template
    /// and parameter
    /// configuration of the StackSet. A stack instance is considered to have
    /// drifted if one or more of
    /// the resources in the associated stack don't match their expected
    /// configuration.
    drifted_stack_instances_count: ?i32,

    /// Status of the StackSet's actual configuration compared to its expected
    /// template and
    /// parameter configuration.
    ///
    /// * `DRIFTED`: One or more of the stack instances belonging to the StackSet
    ///   differs
    /// from the expected template and parameter configuration. A stack instance is
    /// considered to have
    /// drifted if one or more of the resources in the associated stack have
    /// drifted.
    ///
    /// * `NOT_CHECKED`: CloudFormation hasn't checked the StackSet for drift.
    ///
    /// * `IN_SYNC`: All of the stack instances belonging to the StackSet stack
    ///   match the
    /// expected template and parameter configuration.
    drift_status: ?StackSetDriftStatus,

    /// The number of stack instances for which the drift detection operation
    /// failed.
    failed_stack_instances_count: ?i32,

    /// The number of stack instances that are currently being checked for drift.
    in_progress_stack_instances_count: ?i32,

    /// The number of stack instances which match the expected template and
    /// parameter configuration
    /// of the StackSet.
    in_sync_stack_instances_count: ?i32,

    /// Most recent time when CloudFormation performed a drift detection operation
    /// on the StackSet. This
    /// value will be `NULL` for any StackSet that drift detection hasn't yet been
    /// performed
    /// on.
    last_drift_check_timestamp: ?i64,

    /// The total number of stack instances belonging to this StackSet.
    ///
    /// The total number of stack instances is equal to the total of:
    ///
    /// * Stack instances that match the StackSet configuration.
    ///
    /// * Stack instances that have drifted from the StackSet configuration.
    ///
    /// * Stack instances where the drift detection operation has failed.
    ///
    /// * Stack instances currently being checked for drift.
    total_stack_instances_count: ?i32,
};
