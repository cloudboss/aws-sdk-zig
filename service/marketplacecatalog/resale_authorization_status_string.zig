pub const ResaleAuthorizationStatusString = enum {
    draft,
    active,
    restricted,

    pub const json_field_names = .{
        .draft = "Draft",
        .active = "Active",
        .restricted = "Restricted",
    };
};
