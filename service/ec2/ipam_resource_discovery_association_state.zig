pub const IpamResourceDiscoveryAssociationState = enum {
    associate_in_progress,
    associate_complete,
    associate_failed,
    disassociate_in_progress,
    disassociate_complete,
    disassociate_failed,
    isolate_in_progress,
    isolate_complete,
    restore_in_progress,
};
