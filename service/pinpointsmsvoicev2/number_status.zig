pub const NumberStatus = enum {
    pending,
    active,
    associating,
    disassociating,
    deleted,

    pub const json_field_names = .{
        .pending = "PENDING",
        .active = "ACTIVE",
        .associating = "ASSOCIATING",
        .disassociating = "DISASSOCIATING",
        .deleted = "DELETED",
    };
};
