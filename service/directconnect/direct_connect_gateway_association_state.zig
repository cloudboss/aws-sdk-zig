pub const DirectConnectGatewayAssociationState = enum {
    associating,
    associated,
    disassociating,
    disassociated,
    updating,

    pub const json_field_names = .{
        .associating = "associating",
        .associated = "associated",
        .disassociating = "disassociating",
        .disassociated = "disassociated",
        .updating = "updating",
    };
};
