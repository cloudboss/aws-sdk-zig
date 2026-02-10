const ProtocolValue = @import("protocol_value.zig").ProtocolValue;

/// Describes the Connect attachment options.
pub const TransitGatewayConnectOptions = struct {
    /// The tunnel protocol.
    protocol: ?ProtocolValue,
};
