/// Describes the state of a traffic source.
pub const TrafficSourceState = struct {
    /// The unique identifier of the traffic source.
    identifier: ?[]const u8,

    /// Describes the current state of a traffic source.
    ///
    /// The state values are as follows:
    ///
    /// * `Adding` - The Auto Scaling instances are being registered with the load
    /// balancer or target group.
    ///
    /// * `Added` - All Auto Scaling instances are registered with the load balancer
    ///   or
    /// target group.
    ///
    /// * `InService` - For an Elastic Load Balancing load balancer or target group,
    ///   at least
    /// one Auto Scaling instance passed an `ELB` health check. For VPC Lattice, at
    /// least one Auto Scaling instance passed an `VPC_LATTICE` health check.
    ///
    /// * `Removing` - The Auto Scaling instances are being deregistered from the
    /// load balancer or target group. If connection draining (deregistration delay)
    /// is
    /// enabled, Elastic Load Balancing or VPC Lattice waits for in-flight requests
    /// to complete before
    /// deregistering the instances.
    ///
    /// * `Removed` - All Auto Scaling instances are deregistered from the load
    /// balancer or target group.
    state: ?[]const u8,

    /// This is replaced by `Identifier`.
    traffic_source: ?[]const u8,

    /// Provides additional context for the value of `Identifier`.
    ///
    /// The following lists the valid values:
    ///
    /// * `elb` if `Identifier` is the name of a Classic Load Balancer.
    ///
    /// * `elbv2` if `Identifier` is the ARN of an Application Load Balancer,
    ///   Gateway Load Balancer,
    /// or Network Load Balancer target group.
    ///
    /// * `vpc-lattice` if `Identifier` is the ARN of a VPC Lattice
    /// target group.
    ///
    /// Required if the identifier is the name of a Classic Load Balancer.
    @"type": ?[]const u8,
};
