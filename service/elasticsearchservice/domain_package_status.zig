pub const DomainPackageStatus = enum {
    associating,
    association_failed,
    active,
    dissociating,
    dissociation_failed,

    pub const json_field_names = .{
        .associating = "ASSOCIATING",
        .association_failed = "ASSOCIATION_FAILED",
        .active = "ACTIVE",
        .dissociating = "DISSOCIATING",
        .dissociation_failed = "DISSOCIATION_FAILED",
    };
};
