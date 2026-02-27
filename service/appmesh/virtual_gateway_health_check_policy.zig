const VirtualGatewayPortProtocol = @import("virtual_gateway_port_protocol.zig").VirtualGatewayPortProtocol;

/// An object that represents the health check policy for a virtual gateway's
/// listener.
pub const VirtualGatewayHealthCheckPolicy = struct {
    /// The number of consecutive successful health checks that must occur before
    /// declaring the
    /// listener healthy.
    healthy_threshold: i32,

    /// The time period in milliseconds between each health check execution.
    interval_millis: i64,

    /// The destination path for the health check request. This value is only used
    /// if the
    /// specified protocol is HTTP or HTTP/2. For any other protocol, this value is
    /// ignored.
    path: ?[]const u8,

    /// The destination port for the health check request. This port must match the
    /// port defined
    /// in the PortMapping for the listener.
    port: ?i32,

    /// The protocol for the health check request. If you specify `grpc`, then your
    /// service must conform to the [GRPC Health
    /// Checking
    /// Protocol](https://github.com/grpc/grpc/blob/master/doc/health-checking.md).
    protocol: VirtualGatewayPortProtocol,

    /// The amount of time to wait when receiving a response from the health check,
    /// in
    /// milliseconds.
    timeout_millis: i64,

    /// The number of consecutive failed health checks that must occur before
    /// declaring a
    /// virtual gateway unhealthy.
    unhealthy_threshold: i32,

    pub const json_field_names = .{
        .healthy_threshold = "healthyThreshold",
        .interval_millis = "intervalMillis",
        .path = "path",
        .port = "port",
        .protocol = "protocol",
        .timeout_millis = "timeoutMillis",
        .unhealthy_threshold = "unhealthyThreshold",
    };
};
