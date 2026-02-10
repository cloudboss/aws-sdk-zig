const ProtocolValue = @import("protocol_value.zig").ProtocolValue;

/// The options for a Connect attachment.
pub const CreateTransitGatewayConnectRequestOptions = struct {
    /// The tunnel protocol.
    protocol: ProtocolValue,
};
