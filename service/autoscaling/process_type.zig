/// Describes a process type.
///
/// For more information, see [Types
/// of
/// processes](https://docs.aws.amazon.com/autoscaling/ec2/userguide/as-suspend-resume-processes.html#process-types) in the *Amazon EC2 Auto Scaling User Guide*.
pub const ProcessType = struct {
    /// One of the following processes:
    ///
    /// * `Launch`
    ///
    /// * `Terminate`
    ///
    /// * `AddToLoadBalancer`
    ///
    /// * `AlarmNotification`
    ///
    /// * `AZRebalance`
    ///
    /// * `HealthCheck`
    ///
    /// * `InstanceRefresh`
    ///
    /// * `ReplaceUnhealthy`
    ///
    /// * `ScheduledActions`
    process_name: []const u8,
};
