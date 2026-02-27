pub const RegionStatus = enum {
    active,
    adding,
    removing,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .adding = "ADDING",
        .removing = "REMOVING",
    };
};
