const TrafficRoutingConfig = @import("traffic_routing_config.zig").TrafficRoutingConfig;

/// Update policy for a blue/green deployment. If this update policy is
/// specified, SageMaker creates a new fleet during the deployment while
/// maintaining the old fleet. SageMaker flips traffic to the new fleet
/// according to the specified traffic routing configuration. Only one update
/// policy should be used in the deployment configuration. If no update policy
/// is specified, SageMaker uses a blue/green deployment strategy with all at
/// once traffic shifting by default.
pub const BlueGreenUpdatePolicy = struct {
    /// Maximum execution timeout for the deployment. Note that the timeout value
    /// should be larger than the total waiting time specified in
    /// `TerminationWaitInSeconds` and `WaitIntervalInSeconds`.
    maximum_execution_timeout_in_seconds: ?i32 = null,

    /// Additional waiting time in seconds after the completion of an endpoint
    /// deployment before terminating the old endpoint fleet. Default is 0.
    termination_wait_in_seconds: ?i32 = null,

    /// Defines the traffic routing strategy to shift traffic from the old fleet to
    /// the new fleet during an endpoint deployment.
    traffic_routing_configuration: TrafficRoutingConfig,

    pub const json_field_names = .{
        .maximum_execution_timeout_in_seconds = "MaximumExecutionTimeoutInSeconds",
        .termination_wait_in_seconds = "TerminationWaitInSeconds",
        .traffic_routing_configuration = "TrafficRoutingConfiguration",
    };
};
