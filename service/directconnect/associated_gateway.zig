const GatewayType = @import("gateway_type.zig").GatewayType;

/// Information about the associated gateway.
pub const AssociatedGateway = struct {
    /// The ID of the associated gateway.
    id: ?[]const u8,

    /// The ID of the Amazon Web Services account that owns the associated virtual
    /// private gateway or transit gateway.
    owner_account: ?[]const u8,

    /// The Region where the associated gateway is located.
    region: ?[]const u8,

    /// The type of associated gateway.
    type: ?GatewayType,

    pub const json_field_names = .{
        .id = "id",
        .owner_account = "ownerAccount",
        .region = "region",
        .type = "type",
    };
};
