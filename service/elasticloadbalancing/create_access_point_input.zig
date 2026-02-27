const Listener = @import("listener.zig").Listener;
const Tag = @import("tag.zig").Tag;

/// Contains the parameters for CreateLoadBalancer.
pub const CreateAccessPointInput = struct {
    /// One or more Availability Zones from the same region as the load balancer.
    ///
    /// You must specify at least one Availability Zone.
    ///
    /// You can add more Availability Zones after you create the load balancer using
    /// EnableAvailabilityZonesForLoadBalancer.
    availability_zones: ?[]const []const u8,

    /// The listeners.
    ///
    /// For more information, see [Listeners for Your Classic Load
    /// Balancer](https://docs.aws.amazon.com/elasticloadbalancing/latest/classic/elb-listener-config.html)
    /// in the *Classic Load Balancers Guide*.
    listeners: []const Listener,

    /// The name of the load balancer.
    ///
    /// This name must be unique within your set of load balancers for the region,
    /// must have a maximum of 32 characters, must contain only alphanumeric
    /// characters or hyphens, and cannot begin or end with a hyphen.
    load_balancer_name: []const u8,

    /// The type of a load balancer. Valid only for load balancers in a VPC.
    ///
    /// By default, Elastic Load Balancing creates an Internet-facing load balancer
    /// with a DNS name that resolves to public IP addresses.
    /// For more information about Internet-facing and Internal load balancers, see
    /// [Load Balancer
    /// Scheme](https://docs.aws.amazon.com/elasticloadbalancing/latest/userguide/how-elastic-load-balancing-works.html#load-balancer-scheme)
    /// in the *Elastic Load Balancing User Guide*.
    ///
    /// Specify `internal` to create a load balancer with a DNS name that resolves
    /// to private IP addresses.
    scheme: ?[]const u8,

    /// The IDs of the security groups to assign to the load balancer.
    security_groups: ?[]const []const u8,

    /// The IDs of the subnets in your VPC to attach to the load balancer.
    /// Specify one subnet per Availability Zone specified in `AvailabilityZones`.
    subnets: ?[]const []const u8,

    /// A list of tags to assign to the load balancer.
    ///
    /// For more information about tagging your load balancer, see [Tag Your Classic
    /// Load
    /// Balancer](https://docs.aws.amazon.com/elasticloadbalancing/latest/classic/add-remove-tags.html)
    /// in the *Classic Load Balancers Guide*.
    tags: ?[]const Tag,
};
