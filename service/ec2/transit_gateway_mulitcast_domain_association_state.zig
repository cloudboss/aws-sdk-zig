pub const TransitGatewayMulitcastDomainAssociationState = enum {
    pending_acceptance,
    associating,
    associated,
    disassociating,
    disassociated,
    rejected,
    failed,
};
