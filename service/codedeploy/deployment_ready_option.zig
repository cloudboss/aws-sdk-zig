const DeploymentReadyAction = @import("deployment_ready_action.zig").DeploymentReadyAction;

/// Information about how traffic is rerouted to instances in a replacement
/// environment in
/// a blue/green deployment.
pub const DeploymentReadyOption = struct {
    /// Information about when to reroute traffic from an original environment to a
    /// replacement environment in a blue/green deployment.
    ///
    /// * CONTINUE_DEPLOYMENT: Register new instances with the load balancer
    ///   immediately
    /// after the new application revision is installed on the instances in the
    /// replacement environment.
    ///
    /// * STOP_DEPLOYMENT: Do not register new instances with a load balancer unless
    /// traffic rerouting is started using ContinueDeployment. If
    /// traffic rerouting is not started before the end of the specified wait
    /// period,
    /// the deployment status is changed to Stopped.
    action_on_timeout: ?DeploymentReadyAction = null,

    /// The number of minutes to wait before the status of a blue/green deployment
    /// is changed
    /// to Stopped if rerouting is not started manually. Applies only to the
    /// `STOP_DEPLOYMENT` option for `actionOnTimeout`.
    wait_time_in_minutes: i32 = 0,

    pub const json_field_names = .{
        .action_on_timeout = "actionOnTimeout",
        .wait_time_in_minutes = "waitTimeInMinutes",
    };
};
