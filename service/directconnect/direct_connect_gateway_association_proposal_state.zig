pub const DirectConnectGatewayAssociationProposalState = enum {
    requested,
    accepted,
    deleted,

    pub const json_field_names = .{
        .requested = "requested",
        .accepted = "accepted",
        .deleted = "deleted",
    };
};
