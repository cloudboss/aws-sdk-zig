pub const ResolverEndpointDirection = enum {
    inbound,
    outbound,
    inbound_delegation,

    pub const json_field_names = .{
        .inbound = "Inbound",
        .outbound = "Outbound",
        .inbound_delegation = "InboundDelegation",
    };
};
