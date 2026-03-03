const AuthorizerType = @import("authorizer_type.zig").AuthorizerType;
const GatewayProtocolType = @import("gateway_protocol_type.zig").GatewayProtocolType;
const GatewayStatus = @import("gateway_status.zig").GatewayStatus;

/// Contains summary information about a gateway.
pub const GatewaySummary = struct {
    /// The type of authorizer used by the gateway.
    authorizer_type: AuthorizerType,

    /// The timestamp when the gateway was created.
    created_at: i64,

    /// The description of the gateway.
    description: ?[]const u8 = null,

    /// The unique identifier of the gateway.
    gateway_id: []const u8,

    /// The name of the gateway.
    name: []const u8,

    /// The protocol type used by the gateway.
    protocol_type: GatewayProtocolType,

    /// The current status of the gateway.
    status: GatewayStatus,

    /// The timestamp when the gateway was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .authorizer_type = "authorizerType",
        .created_at = "createdAt",
        .description = "description",
        .gateway_id = "gatewayId",
        .name = "name",
        .protocol_type = "protocolType",
        .status = "status",
        .updated_at = "updatedAt",
    };
};
