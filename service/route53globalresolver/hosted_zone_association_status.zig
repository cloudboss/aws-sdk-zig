pub const HostedZoneAssociationStatus = enum {
    creating,
    operational,
    deleting,

    pub const json_field_names = .{
        .creating = "CREATING",
        .operational = "OPERATIONAL",
        .deleting = "DELETING",
    };
};
