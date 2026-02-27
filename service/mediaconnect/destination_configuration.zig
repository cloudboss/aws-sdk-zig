const Interface = @import("interface.zig").Interface;

/// The transport parameters that you want to associate with an outbound media
/// stream.
pub const DestinationConfiguration = struct {
    /// The IP address where you want MediaConnect to send contents of the media
    /// stream.
    destination_ip: []const u8,

    /// The port that you want MediaConnect to use when it distributes the media
    /// stream to the output.
    destination_port: i32,

    /// The VPC interface that you want to use for the media stream associated with
    /// the output.
    interface: Interface,

    /// The IP address that the receiver requires in order to establish a connection
    /// with the flow. This value is represented by the elastic network interface IP
    /// address of the VPC. This field applies only to outputs that use the CDI or
    /// ST 2110 JPEG XS or protocol.
    outbound_ip: []const u8,

    pub const json_field_names = .{
        .destination_ip = "DestinationIp",
        .destination_port = "DestinationPort",
        .interface = "Interface",
        .outbound_ip = "OutboundIp",
    };
};
