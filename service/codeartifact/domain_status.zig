pub const DomainStatus = enum {
    active,
    deleted,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .deleted = "DELETED",
    };
};
