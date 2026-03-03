const StackResourceDriftStatus = @import("stack_resource_drift_status.zig").StackResourceDriftStatus;

/// Contains information about whether the resource's actual configuration
/// differs, or has
/// *drifted*, from its expected configuration.
pub const StackResourceDriftInformation = struct {
    /// When CloudFormation last checked if the resource had drifted from its
    /// expected
    /// configuration.
    last_check_timestamp: ?i64 = null,

    /// Status of the resource's actual configuration compared to its expected
    /// configuration
    ///
    /// * `DELETED`: The resource differs from its expected configuration in that it
    ///   has
    /// been deleted.
    ///
    /// * `MODIFIED`: The resource differs from its expected configuration.
    ///
    /// * `NOT_CHECKED`: CloudFormation has not checked if the resource differs from
    ///   its
    /// expected configuration.
    ///
    /// Any resources that do not currently support drift detection have a status of
    /// `NOT_CHECKED`. For more information, see [Resource
    /// type support for imports and drift
    /// detection](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/resource-import-supported-resources.html).
    ///
    /// * `IN_SYNC`: The resource's actual configuration matches its expected
    /// configuration.
    stack_resource_drift_status: StackResourceDriftStatus,
};
