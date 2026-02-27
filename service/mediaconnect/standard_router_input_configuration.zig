const RouterInputProtocol = @import("router_input_protocol.zig").RouterInputProtocol;
const RouterInputProtocolConfiguration = @import("router_input_protocol_configuration.zig").RouterInputProtocolConfiguration;

/// The configuration settings for a standard router input, including the
/// protocol, protocol-specific configuration, network interface, and
/// availability zone.
pub const StandardRouterInputConfiguration = struct {
    /// The Amazon Resource Name (ARN) of the network interface associated with the
    /// standard router input.
    network_interface_arn: []const u8,

    /// The protocol used by the standard router input.
    protocol: ?RouterInputProtocol,

    /// The configuration settings for the protocol used by the standard router
    /// input.
    protocol_configuration: RouterInputProtocolConfiguration,

    pub const json_field_names = .{
        .network_interface_arn = "NetworkInterfaceArn",
        .protocol = "Protocol",
        .protocol_configuration = "ProtocolConfiguration",
    };
};
