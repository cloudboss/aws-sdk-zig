const EndpointDescription = @import("endpoint_description.zig").EndpointDescription;
const HealthCheckProtocol = @import("health_check_protocol.zig").HealthCheckProtocol;
const PortOverride = @import("port_override.zig").PortOverride;

/// A complex type for the endpoint group. An Amazon Web Services Region can
/// have only one endpoint group for a specific listener.
pub const EndpointGroup = struct {
    /// The list of endpoint objects.
    endpoint_descriptions: ?[]const EndpointDescription,

    /// The Amazon Resource Name (ARN) of the endpoint group.
    endpoint_group_arn: ?[]const u8,

    /// The Amazon Web Services Region where the endpoint group is located.
    endpoint_group_region: ?[]const u8,

    /// The time—10 seconds or 30 seconds—between health checks for each endpoint.
    /// The default value is 30.
    health_check_interval_seconds: ?i32,

    /// If the protocol is HTTP/S, then this value provides the ping path that
    /// Global Accelerator uses for the destination on the
    /// endpoints for health checks. The default is slash (/).
    health_check_path: ?[]const u8,

    /// The port that Global Accelerator uses to perform health checks on endpoints
    /// that are part of this endpoint group.
    ///
    /// The default port is the port for the listener that this endpoint group is
    /// associated with. If the listener port is a
    /// list, Global Accelerator uses the first specified port in the list of ports.
    health_check_port: ?i32,

    /// The protocol that Global Accelerator uses to perform health checks on
    /// endpoints that are part of this endpoint group. The default
    /// value is TCP.
    health_check_protocol: ?HealthCheckProtocol,

    /// Allows you to override the destination ports used to route traffic to an
    /// endpoint.
    /// Using a port override lets you map a list of external destination ports
    /// (that your
    /// users send traffic to) to a list of internal destination ports that you want
    /// an application
    /// endpoint to receive traffic on.
    port_overrides: ?[]const PortOverride,

    /// The number of consecutive health checks required to set the state of a
    /// healthy endpoint to unhealthy, or to set an
    /// unhealthy endpoint to healthy. The default value is 3.
    threshold_count: ?i32,

    /// The percentage of traffic to send to an Amazon Web Services Region.
    /// Additional traffic is distributed to other endpoint groups for
    /// this listener.
    ///
    /// Use this action to increase (dial up) or decrease (dial down) traffic to a
    /// specific Region. The percentage is
    /// applied to the traffic that would otherwise have been routed to the Region
    /// based on optimal routing.
    ///
    /// The default value is 100.
    traffic_dial_percentage: ?f32,

    pub const json_field_names = .{
        .endpoint_descriptions = "EndpointDescriptions",
        .endpoint_group_arn = "EndpointGroupArn",
        .endpoint_group_region = "EndpointGroupRegion",
        .health_check_interval_seconds = "HealthCheckIntervalSeconds",
        .health_check_path = "HealthCheckPath",
        .health_check_port = "HealthCheckPort",
        .health_check_protocol = "HealthCheckProtocol",
        .port_overrides = "PortOverrides",
        .threshold_count = "ThresholdCount",
        .traffic_dial_percentage = "TrafficDialPercentage",
    };
};
