const StackDriftStatus = @import("stack_drift_status.zig").StackDriftStatus;

/// Contains information about whether the stack's actual configuration differs,
/// or has
/// *drifted*, from its expected configuration, as defined in the stack template
/// and any values specified as template parameters. A stack is considered to
/// have drifted if one or
/// more of its resources have drifted.
pub const StackDriftInformation = struct {
    /// Most recent time when a drift detection operation was initiated on the
    /// stack, or any of its
    /// individual resources that support drift detection.
    last_check_timestamp: ?i64,

    /// Status of the stack's actual configuration compared to its expected template
    /// configuration.
    ///
    /// * `DRIFTED`: The stack differs from its expected template configuration. A
    ///   stack
    /// is considered to have drifted if one or more of its resources have drifted.
    ///
    /// * `NOT_CHECKED`: CloudFormation hasn't checked if the stack differs from its
    ///   expected
    /// template configuration.
    ///
    /// * `IN_SYNC`: The stack's actual configuration matches its expected template
    /// configuration.
    ///
    /// * `UNKNOWN`: CloudFormation could not run drift detection for a resource in
    ///   the
    /// stack.
    stack_drift_status: StackDriftStatus,
};
