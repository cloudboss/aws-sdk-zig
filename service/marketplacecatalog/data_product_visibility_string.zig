pub const DataProductVisibilityString = enum {
    limited,
    public,
    restricted,
    unavailable,
    draft,

    pub const json_field_names = .{
        .limited = "Limited",
        .public = "Public",
        .restricted = "Restricted",
        .unavailable = "Unavailable",
        .draft = "Draft",
    };
};
