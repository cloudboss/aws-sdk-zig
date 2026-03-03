const AutoScalingGroup = @import("auto_scaling_group.zig").AutoScalingGroup;
const Instance = @import("instance.zig").Instance;
const LaunchConfiguration = @import("launch_configuration.zig").LaunchConfiguration;
const LaunchTemplate = @import("launch_template.zig").LaunchTemplate;
const LoadBalancer = @import("load_balancer.zig").LoadBalancer;
const Queue = @import("queue.zig").Queue;
const Trigger = @import("trigger.zig").Trigger;

/// Describes the AWS resources in use by this environment. This data is live.
pub const EnvironmentResourceDescription = struct {
    /// The `AutoScalingGroups` used by this environment.
    auto_scaling_groups: ?[]const AutoScalingGroup = null,

    /// The name of the environment.
    environment_name: ?[]const u8 = null,

    /// The Amazon EC2 instances used by this environment.
    instances: ?[]const Instance = null,

    /// The Auto Scaling launch configurations in use by this environment.
    launch_configurations: ?[]const LaunchConfiguration = null,

    /// The Amazon EC2 launch templates in use by this environment.
    launch_templates: ?[]const LaunchTemplate = null,

    /// The LoadBalancers in use by this environment.
    load_balancers: ?[]const LoadBalancer = null,

    /// The queues used by this environment.
    queues: ?[]const Queue = null,

    /// The `AutoScaling` triggers in use by this environment.
    triggers: ?[]const Trigger = null,
};
