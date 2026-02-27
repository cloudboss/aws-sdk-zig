pub const ListingStatus = enum {
    creating,
    active,
    inactive,

    pub const json_field_names = .{
        .creating = "CREATING",
        .active = "ACTIVE",
        .inactive = "INACTIVE",
    };
};
