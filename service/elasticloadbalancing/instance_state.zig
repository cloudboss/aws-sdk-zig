/// Information about the state of an EC2 instance.
pub const InstanceState = struct {
    /// A description of the instance state. This string can contain one or more of
    /// the following messages.
    ///
    /// * `N/A`
    ///
    /// * `A transient error occurred. Please try again later.`
    ///
    /// * `Instance has failed at least the UnhealthyThreshold number of health
    ///   checks consecutively.`
    ///
    /// * `Instance has not passed the configured HealthyThreshold number of health
    ///   checks consecutively.`
    ///
    /// * `Instance registration is still in progress.`
    ///
    /// * `Instance is in the EC2 Availability Zone for which LoadBalancer is not
    ///   configured to route traffic to.`
    ///
    /// * `Instance is not currently registered with the LoadBalancer.`
    ///
    /// * `Instance deregistration currently in progress.`
    ///
    /// * `Disable Availability Zone is currently in progress.`
    ///
    /// * `Instance is in pending state.`
    ///
    /// * `Instance is in stopped state.`
    ///
    /// * `Instance is in terminated state.`
    description: ?[]const u8 = null,

    /// The ID of the instance.
    instance_id: ?[]const u8 = null,

    /// Information about the cause of `OutOfService` instances.
    /// Specifically, whether the cause is Elastic Load Balancing or the instance.
    ///
    /// Valid values: `ELB` | `Instance` | `N/A`
    reason_code: ?[]const u8 = null,

    /// The current state of the instance.
    ///
    /// Valid values: `InService` | `OutOfService` | `Unknown`
    state: ?[]const u8 = null,
};
