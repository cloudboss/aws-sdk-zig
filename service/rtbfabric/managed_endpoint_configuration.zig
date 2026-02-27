const AutoScalingGroupsConfiguration = @import("auto_scaling_groups_configuration.zig").AutoScalingGroupsConfiguration;
const EksEndpointsConfiguration = @import("eks_endpoints_configuration.zig").EksEndpointsConfiguration;

/// Describes the configuration of a managed endpoint.
pub const ManagedEndpointConfiguration = union(enum) {
    /// Describes the configuration of an auto scaling group.
    auto_scaling_groups: ?AutoScalingGroupsConfiguration,
    /// Describes the configuration of an Amazon Elastic Kubernetes Service
    /// endpoint.
    eks_endpoints: ?EksEndpointsConfiguration,

    pub const json_field_names = .{
        .auto_scaling_groups = "autoScalingGroups",
        .eks_endpoints = "eksEndpoints",
    };
};
