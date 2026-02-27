pub const ContainerProductVisibilityString = enum {
    limited,
    public,
    restricted,
    draft,

    pub const json_field_names = .{
        .limited = "Limited",
        .public = "Public",
        .restricted = "Restricted",
        .draft = "Draft",
    };
};
