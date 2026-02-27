pub const WafStatus = enum {
    associating,
    association_failed,
    association_success,
    disassociating,
    disassociation_failed,

    pub const json_field_names = .{
        .associating = "ASSOCIATING",
        .association_failed = "ASSOCIATION_FAILED",
        .association_success = "ASSOCIATION_SUCCESS",
        .disassociating = "DISASSOCIATING",
        .disassociation_failed = "DISASSOCIATION_FAILED",
    };
};
