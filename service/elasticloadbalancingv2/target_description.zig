/// Information about a target.
pub const TargetDescription = struct {
    /// An Availability Zone or `all`. This determines whether the target receives
    /// traffic from the load balancer nodes in the specified Availability Zone or
    /// from all enabled
    /// Availability Zones for the load balancer.
    ///
    /// For Application Load Balancer target groups, the specified Availability Zone
    /// value is only applicable
    /// when cross-zone load balancing is off. Otherwise the parameter is ignored
    /// and treated
    /// as `all`.
    ///
    /// This parameter is not supported if the target type of the target group is
    /// `instance` or `alb`.
    ///
    /// If the target type is `ip` and the IP address is in a subnet of the VPC for
    /// the target group,
    /// the Availability Zone is automatically detected and this parameter is
    /// optional. If the IP address is outside
    /// the VPC, this parameter is required.
    ///
    /// For Application Load Balancer target groups with cross-zone load balancing
    /// off, if the target type
    /// is `ip` and the IP address is outside of the VPC for the target group, this
    /// should be an
    /// Availability Zone inside the VPC for the target group.
    ///
    /// If the target type is `lambda`, this parameter is optional and the only
    /// supported value is `all`.
    availability_zone: ?[]const u8 = null,

    /// The ID of the target. If the target type of the target group is `instance`,
    /// specify an instance ID. If the target type is `ip`, specify an IP address.
    /// If the
    /// target type is `lambda`, specify the ARN of the Lambda function. If the
    /// target type
    /// is `alb`, specify the ARN of the Application Load Balancer target.
    id: []const u8,

    /// The port on which the target is listening. If the target group protocol is
    /// GENEVE, the
    /// supported port is 6081. If the target type is `alb`, the targeted
    /// Application Load
    /// Balancer must have at least one listener whose port matches the target group
    /// port. This
    /// parameter is not used if the target is a Lambda function.
    port: ?i32 = null,

    /// The server ID for the targets. This value is required if the protocol is
    /// `QUIC` or `TCP_QUIC` and can't be used with other protocols.
    ///
    /// The ID consists of the `0x` prefix followed by 16 hexadecimal characters.
    /// Any letters must be lowercase. The value must be unique at the listener
    /// level. You can't
    /// modify the server ID for a registered target. You must deregister the target
    /// and then
    /// provide a new server ID when you register the target again.
    quic_server_id: ?[]const u8 = null,
};
