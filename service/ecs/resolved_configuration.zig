const ServiceRevisionLoadBalancer = @import("service_revision_load_balancer.zig").ServiceRevisionLoadBalancer;
const ServiceRevisionVpcLatticeConfiguration = @import("service_revision_vpc_lattice_configuration.zig").ServiceRevisionVpcLatticeConfiguration;

/// The resolved configuration for a service revision, which contains the actual
/// resources your service revision uses, such as which target groups serve
/// traffic.
pub const ResolvedConfiguration = struct {
    /// The resolved load balancer configuration for the service revision. This
    /// includes information about which target groups serve traffic and which
    /// listener rules direct traffic to them.
    load_balancers: ?[]const ServiceRevisionLoadBalancer = null,

    /// The resolved VPC Lattice configuration for the service revision. This
    /// includes information about which target groups serve traffic and which
    /// listener rules direct traffic to them.
    vpc_lattice_configurations: ?[]const ServiceRevisionVpcLatticeConfiguration = null,

    pub const json_field_names = .{
        .load_balancers = "loadBalancers",
        .vpc_lattice_configurations = "vpcLatticeConfigurations",
    };
};
