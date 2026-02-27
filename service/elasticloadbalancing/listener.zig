/// Information about a listener.
///
/// For information about the protocols and the ports supported by Elastic Load
/// Balancing, see [Listeners for Your Classic Load
/// Balancer](https://docs.aws.amazon.com/elasticloadbalancing/latest/classic/elb-listener-config.html)
/// in the *Classic Load Balancers Guide*.
pub const Listener = struct {
    /// The port on which the instance is listening.
    instance_port: i32,

    /// The protocol to use for routing traffic to instances: HTTP, HTTPS, TCP, or
    /// SSL.
    ///
    /// If the front-end protocol is TCP or SSL, the back-end protocol must be TCP
    /// or SSL.
    /// If the front-end protocol is HTTP or HTTPS, the back-end protocol must be
    /// HTTP or HTTPS.
    ///
    /// If there is another listener with the same `InstancePort` whose
    /// `InstanceProtocol` is secure,
    /// (HTTPS or SSL), the listener's `InstanceProtocol` must also be secure.
    ///
    /// If there is another listener with the same `InstancePort` whose
    /// `InstanceProtocol` is HTTP or TCP,
    /// the listener's `InstanceProtocol` must be HTTP or TCP.
    instance_protocol: ?[]const u8,

    /// The port on which the load balancer is listening. On EC2-VPC, you can
    /// specify any port from the range 1-65535. On EC2-Classic, you can specify any
    /// port from the following list: 25, 80, 443, 465, 587, 1024-65535.
    load_balancer_port: i32 = 0,

    /// The load balancer transport protocol to use for routing: HTTP, HTTPS, TCP,
    /// or SSL.
    protocol: []const u8,

    /// The Amazon Resource Name (ARN) of the server certificate.
    ssl_certificate_id: ?[]const u8,
};
