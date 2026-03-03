const RouterOutputProtocol = @import("router_output_protocol.zig").RouterOutputProtocol;
const RouterOutputProtocolConfiguration = @import("router_output_protocol_configuration.zig").RouterOutputProtocolConfiguration;

/// The configuration settings for a standard router output, including the
/// protocol, protocol-specific configuration, network interface, and
/// availability zone.
pub const StandardRouterOutputConfiguration = struct {
    /// The Amazon Resource Name (ARN) of the network interface associated with the
    /// standard router output.
    network_interface_arn: []const u8,

    /// The protocol used by the standard router output.
    protocol: ?RouterOutputProtocol = null,

    /// The configuration settings for the protocol used by the standard router
    /// output.
    protocol_configuration: RouterOutputProtocolConfiguration,

    pub const json_field_names = .{
        .network_interface_arn = "NetworkInterfaceArn",
        .protocol = "Protocol",
        .protocol_configuration = "ProtocolConfiguration",
    };
};
