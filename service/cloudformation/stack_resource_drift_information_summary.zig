const StackResourceDriftStatus = @import("stack_resource_drift_status.zig").StackResourceDriftStatus;

/// Summarizes information about whether the resource's actual configuration
/// differs, or has
/// *drifted*, from its expected configuration.
pub const StackResourceDriftInformationSummary = struct {
    /// When CloudFormation last checked if the resource had drifted from its
    /// expected
    /// configuration.
    last_check_timestamp: ?i64,

    /// Status of the resource's actual configuration compared to its expected
    /// configuration.
    ///
    /// * `DELETED`: The resource differs from its expected configuration in that it
    ///   has
    /// been deleted.
    ///
    /// * `MODIFIED`: The resource differs from its expected configuration.
    ///
    /// * `NOT_CHECKED`: CloudFormation hasn't checked if the resource differs from
    ///   its
    /// expected configuration.
    ///
    /// Any resources that don't currently support drift detection have a status of
    /// `NOT_CHECKED`. For more information, see [Resource
    /// type support for imports and drift
    /// detection](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/resource-import-supported-resources.html). If you performed an ContinueUpdateRollback operation on a stack, any resources included in
    /// `ResourcesToSkip` will also have a status of `NOT_CHECKED`. For more
    /// information about skipping resources during rollback operations, see
    /// [Continue rolling back an
    /// update](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-cfn-updating-stacks-continueupdaterollback.html) in the *CloudFormation User Guide*.
    ///
    /// * `IN_SYNC`: The resource's actual configuration matches its expected
    /// configuration.
    stack_resource_drift_status: StackResourceDriftStatus,
};
