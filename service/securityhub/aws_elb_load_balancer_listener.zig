/// Information about a load balancer listener.
pub const AwsElbLoadBalancerListener = struct {
    /// The port on which the instance is listening.
    instance_port: ?i32 = null,

    /// The protocol to use to route traffic to instances.
    ///
    /// Valid values: `HTTP` | `HTTPS` | `TCP` |
    /// `SSL`
    instance_protocol: ?[]const u8 = null,

    /// The port on which the load balancer is listening.
    ///
    /// On EC2-VPC, you can specify any port from the range 1-65535.
    ///
    /// On EC2-Classic, you can specify any port from the following list: 25, 80,
    /// 443, 465, 587,
    /// 1024-65535.
    load_balancer_port: ?i32 = null,

    /// The load balancer transport protocol to use for routing.
    ///
    /// Valid values: `HTTP` | `HTTPS` | `TCP` |
    /// `SSL`
    protocol: ?[]const u8 = null,

    /// The ARN of the server certificate.
    ssl_certificate_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .instance_port = "InstancePort",
        .instance_protocol = "InstanceProtocol",
        .load_balancer_port = "LoadBalancerPort",
        .protocol = "Protocol",
        .ssl_certificate_id = "SslCertificateId",
    };
};
