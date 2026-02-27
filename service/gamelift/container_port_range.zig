const IpProtocol = @import("ip_protocol.zig").IpProtocol;

/// A set of one or more port numbers that can be opened on the container, and
/// the supported
/// network protocol.
///
/// **Part of:**
/// [ContainerPortConfiguration](https://docs.aws.amazon.com/gamelift/latest/apireference/API_ContainerPortConfiguration.html)
pub const ContainerPortRange = struct {
    /// A starting value for the range of allowed port numbers.
    from_port: i32,

    /// The network protocol that these ports support.
    protocol: IpProtocol,

    /// An ending value for the range of allowed port numbers.
    /// Port numbers are end-inclusive.
    /// This value must be equal to or greater than `FromPort`.
    to_port: i32,

    pub const json_field_names = .{
        .from_port = "FromPort",
        .protocol = "Protocol",
        .to_port = "ToPort",
    };
};
