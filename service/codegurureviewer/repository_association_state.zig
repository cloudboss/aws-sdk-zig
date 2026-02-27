pub const RepositoryAssociationState = enum {
    associated,
    associating,
    failed,
    disassociating,
    disassociated,

    pub const json_field_names = .{
        .associated = "ASSOCIATED",
        .associating = "ASSOCIATING",
        .failed = "FAILED",
        .disassociating = "DISASSOCIATING",
        .disassociated = "DISASSOCIATED",
    };
};
