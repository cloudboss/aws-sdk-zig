pub const ResourceShareAssociationStatus = enum {
    associating,
    associated,
    failed,
    disassociating,
    disassociated,
    suspended,
    suspending,
    restoring,

    pub const json_field_names = .{
        .associating = "ASSOCIATING",
        .associated = "ASSOCIATED",
        .failed = "FAILED",
        .disassociating = "DISASSOCIATING",
        .disassociated = "DISASSOCIATED",
        .suspended = "SUSPENDED",
        .suspending = "SUSPENDING",
        .restoring = "RESTORING",
    };
};
