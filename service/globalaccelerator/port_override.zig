/// Override specific listener ports used to route traffic to endpoints that are
/// part of an endpoint group.
/// For example, you can create a port override in which the listener
/// receives user traffic on ports 80 and 443, but your accelerator routes that
/// traffic to ports 1080
/// and 1443, respectively, on the endpoints.
///
/// For more information, see [
/// Overriding listener
/// ports](https://docs.aws.amazon.com/global-accelerator/latest/dg/about-endpoint-groups-port-override.html) in the *Global Accelerator Developer Guide*.
pub const PortOverride = struct {
    /// The endpoint port that you want a listener port to be mapped to. This is the
    /// port on the endpoint,
    /// such as the Application Load Balancer or Amazon EC2 instance.
    endpoint_port: ?i32 = null,

    /// The listener port that you want to map to a specific endpoint port. This is
    /// the port that user traffic
    /// arrives to the Global Accelerator on.
    listener_port: ?i32 = null,

    pub const json_field_names = .{
        .endpoint_port = "EndpointPort",
        .listener_port = "ListenerPort",
    };
};
