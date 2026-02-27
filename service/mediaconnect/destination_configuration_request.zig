const InterfaceRequest = @import("interface_request.zig").InterfaceRequest;

/// The definition of a media stream that you want to associate with the output.
pub const DestinationConfigurationRequest = struct {
    /// The IP address where you want MediaConnect to send contents of the media
    /// stream.
    destination_ip: []const u8,

    /// The port that you want MediaConnect to use when it distributes the media
    /// stream to the output.
    destination_port: i32,

    /// The VPC interface that you want to use for the media stream associated with
    /// the output.
    interface: InterfaceRequest,

    pub const json_field_names = .{
        .destination_ip = "DestinationIp",
        .destination_port = "DestinationPort",
        .interface = "Interface",
    };
};
