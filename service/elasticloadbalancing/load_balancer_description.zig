const BackendServerDescription = @import("backend_server_description.zig").BackendServerDescription;
const HealthCheck = @import("health_check.zig").HealthCheck;
const Instance = @import("instance.zig").Instance;
const ListenerDescription = @import("listener_description.zig").ListenerDescription;
const Policies = @import("policies.zig").Policies;
const SourceSecurityGroup = @import("source_security_group.zig").SourceSecurityGroup;

/// Information about a load balancer.
pub const LoadBalancerDescription = struct {
    /// The Availability Zones for the load balancer.
    availability_zones: ?[]const []const u8,

    /// Information about your EC2 instances.
    backend_server_descriptions: ?[]const BackendServerDescription,

    /// The DNS name of the load balancer.
    ///
    /// For more information, see [Configure a Custom Domain
    /// Name](https://docs.aws.amazon.com/elasticloadbalancing/latest/classic/using-domain-names-with-elb.html)
    /// in the *Classic Load Balancers Guide*.
    canonical_hosted_zone_name: ?[]const u8,

    /// The ID of the Amazon Route 53 hosted zone for the load balancer.
    canonical_hosted_zone_name_id: ?[]const u8,

    /// The date and time the load balancer was created.
    created_time: ?i64,

    /// The DNS name of the load balancer.
    dns_name: ?[]const u8,

    /// Information about the health checks conducted on the load balancer.
    health_check: ?HealthCheck,

    /// The IDs of the instances for the load balancer.
    instances: ?[]const Instance,

    /// The listeners for the load balancer.
    listener_descriptions: ?[]const ListenerDescription,

    /// The name of the load balancer.
    load_balancer_name: ?[]const u8,

    /// The policies defined for the load balancer.
    policies: ?Policies,

    /// The type of load balancer. Valid only for load balancers in a VPC.
    ///
    /// If `Scheme` is `internet-facing`, the load balancer
    /// has a public DNS name that resolves to a public IP address.
    ///
    /// If `Scheme` is `internal`, the load balancer has a public
    /// DNS name that resolves to a private IP address.
    scheme: ?[]const u8,

    /// The security groups for the load balancer. Valid only for load balancers in
    /// a VPC.
    security_groups: ?[]const []const u8,

    /// The security group for the load balancer, which you can use as part of your
    /// inbound rules for your registered instances.
    /// To only allow traffic from load balancers, add a security group rule that
    /// specifies this source security group as the inbound source.
    source_security_group: ?SourceSecurityGroup,

    /// The IDs of the subnets for the load balancer.
    subnets: ?[]const []const u8,

    /// The ID of the VPC for the load balancer.
    vpc_id: ?[]const u8,
};
