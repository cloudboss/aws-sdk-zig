pub const AsnAssociationState = enum {
    disassociated,
    failed_disassociation,
    failed_association,
    pending_disassociation,
    pending_association,
    associated,
};
