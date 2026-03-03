const RouteFilterPrefix = @import("route_filter_prefix.zig").RouteFilterPrefix;
const AssociatedCoreNetwork = @import("associated_core_network.zig").AssociatedCoreNetwork;
const AssociatedGateway = @import("associated_gateway.zig").AssociatedGateway;
const DirectConnectGatewayAssociationState = @import("direct_connect_gateway_association_state.zig").DirectConnectGatewayAssociationState;

/// Information about an association between a Direct Connect gateway and a
/// virtual private gateway or transit gateway.
pub const DirectConnectGatewayAssociation = struct {
    /// The Amazon VPC prefixes to advertise to the Direct Connect gateway.
    allowed_prefixes_to_direct_connect_gateway: ?[]const RouteFilterPrefix = null,

    /// The ID of the Cloud WAN core network associated with the Direct Connect
    /// gateway attachment.
    associated_core_network: ?AssociatedCoreNetwork = null,

    /// Information about the associated gateway.
    associated_gateway: ?AssociatedGateway = null,

    /// The ID of the Direct Connect gateway association.
    association_id: ?[]const u8 = null,

    /// The state of the association. The following are the possible values:
    ///
    /// * `associating`: The initial state after calling
    ///   CreateDirectConnectGatewayAssociation.
    ///
    /// * `associated`: The Direct Connect gateway and virtual private gateway or
    ///   transit gateway are successfully associated and ready to pass traffic.
    ///
    /// * `disassociating`: The initial state after calling
    ///   DeleteDirectConnectGatewayAssociation.
    ///
    /// * `disassociated`: The virtual private gateway or transit gateway is
    ///   disassociated from the Direct Connect gateway. Traffic flow between the
    ///   Direct Connect gateway and virtual private gateway or transit gateway is
    ///   stopped.
    ///
    /// * `updating`: The CIDR blocks for the virtual private gateway or transit
    ///   gateway are currently being updated. This could
    /// be new CIDR blocks added or current CIDR blocks removed.
    association_state: ?DirectConnectGatewayAssociationState = null,

    /// The ID of the Direct Connect gateway.
    direct_connect_gateway_id: ?[]const u8 = null,

    /// The ID of the Amazon Web Services account that owns the associated gateway.
    direct_connect_gateway_owner_account: ?[]const u8 = null,

    /// The error message if the state of an object failed to advance.
    state_change_error: ?[]const u8 = null,

    /// The ID of the virtual private gateway. Applies only to private virtual
    /// interfaces.
    virtual_gateway_id: ?[]const u8 = null,

    /// The ID of the Amazon Web Services account that owns the virtual private
    /// gateway.
    virtual_gateway_owner_account: ?[]const u8 = null,

    /// The Amazon Web Services Region where the virtual private gateway is located.
    virtual_gateway_region: ?[]const u8 = null,

    pub const json_field_names = .{
        .allowed_prefixes_to_direct_connect_gateway = "allowedPrefixesToDirectConnectGateway",
        .associated_core_network = "associatedCoreNetwork",
        .associated_gateway = "associatedGateway",
        .association_id = "associationId",
        .association_state = "associationState",
        .direct_connect_gateway_id = "directConnectGatewayId",
        .direct_connect_gateway_owner_account = "directConnectGatewayOwnerAccount",
        .state_change_error = "stateChangeError",
        .virtual_gateway_id = "virtualGatewayId",
        .virtual_gateway_owner_account = "virtualGatewayOwnerAccount",
        .virtual_gateway_region = "virtualGatewayRegion",
    };
};
