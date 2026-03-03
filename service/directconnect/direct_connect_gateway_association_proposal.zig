const AssociatedGateway = @import("associated_gateway.zig").AssociatedGateway;
const RouteFilterPrefix = @import("route_filter_prefix.zig").RouteFilterPrefix;
const DirectConnectGatewayAssociationProposalState = @import("direct_connect_gateway_association_proposal_state.zig").DirectConnectGatewayAssociationProposalState;

/// Information about the proposal request to attach a virtual private gateway
/// to a Direct Connect gateway.
pub const DirectConnectGatewayAssociationProposal = struct {
    /// Information about the associated gateway.
    associated_gateway: ?AssociatedGateway = null,

    /// The ID of the Direct Connect gateway.
    direct_connect_gateway_id: ?[]const u8 = null,

    /// The ID of the Amazon Web Services account that owns the Direct Connect
    /// gateway.
    direct_connect_gateway_owner_account: ?[]const u8 = null,

    /// The existing Amazon VPC prefixes advertised to the Direct Connect gateway.
    existing_allowed_prefixes_to_direct_connect_gateway: ?[]const RouteFilterPrefix = null,

    /// The ID of the association proposal.
    proposal_id: ?[]const u8 = null,

    /// The state of the proposal. The following are possible values:
    ///
    /// * `accepted`: The proposal has been accepted. The Direct Connect gateway
    ///   association is available to use in this state.
    ///
    /// * `deleted`: The proposal has been deleted by the owner that made the
    ///   proposal. The Direct Connect gateway association cannot be used in this
    ///   state.
    ///
    /// * `requested`: The proposal has been requested. The Direct Connect gateway
    ///   association cannot be used in this state.
    proposal_state: ?DirectConnectGatewayAssociationProposalState = null,

    /// The Amazon VPC prefixes to advertise to the Direct Connect gateway.
    requested_allowed_prefixes_to_direct_connect_gateway: ?[]const RouteFilterPrefix = null,

    pub const json_field_names = .{
        .associated_gateway = "associatedGateway",
        .direct_connect_gateway_id = "directConnectGatewayId",
        .direct_connect_gateway_owner_account = "directConnectGatewayOwnerAccount",
        .existing_allowed_prefixes_to_direct_connect_gateway = "existingAllowedPrefixesToDirectConnectGateway",
        .proposal_id = "proposalId",
        .proposal_state = "proposalState",
        .requested_allowed_prefixes_to_direct_connect_gateway = "requestedAllowedPrefixesToDirectConnectGateway",
    };
};
