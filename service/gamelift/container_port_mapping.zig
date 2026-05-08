const IpProtocol = @import("ip_protocol.zig").IpProtocol;

/// Describes a mapping between a container port and a connection port on a
/// fleet
/// instance. You define container ports in a container group definition. Amazon
/// GameLift Servers assigns
/// connection ports when it deploys the container group to an instance.
///
/// **Part of:**
/// [ContainerGroupPortMapping](https://docs.aws.amazon.com/gamelift/latest/apireference/API_ContainerGroupPortMapping.html)
pub const ContainerPortMapping = struct {
    /// The port number on the fleet instance that maps to the container port.
    /// Connection
    /// ports are assigned by Amazon GameLift Servers when the container group is
    /// deployed to an
    /// instance.
    connection_port: ?i32 = null,

    /// The port number on the container. This port is defined in the container
    /// group
    /// definition. Container port numbers must be unique within a container group
    /// definition.
    container_port: ?i32 = null,

    /// The network protocol for the port mapping. Valid values are `TCP` or
    /// `UDP`.
    protocol: ?IpProtocol = null,

    pub const json_field_names = .{
        .connection_port = "ConnectionPort",
        .container_port = "ContainerPort",
        .protocol = "Protocol",
    };
};
