const Protocol = @import("protocol.zig").Protocol;

/// For a custom routing accelerator, describes the port range and protocol for
/// all endpoints
/// (virtual private cloud subnets) in an endpoint group to accept client
/// traffic on.
pub const CustomRoutingDestinationDescription = struct {
    /// The first port, inclusive, in the range of ports for the endpoint group that
    /// is associated with a custom routing accelerator.
    from_port: ?i32,

    /// The protocol for the endpoint group that is associated with a custom routing
    /// accelerator. The protocol can be either TCP or UDP.
    protocols: ?[]const Protocol,

    /// The last port, inclusive, in the range of ports for the endpoint group that
    /// is associated with a custom routing accelerator.
    to_port: ?i32,

    pub const json_field_names = .{
        .from_port = "FromPort",
        .protocols = "Protocols",
        .to_port = "ToPort",
    };
};
