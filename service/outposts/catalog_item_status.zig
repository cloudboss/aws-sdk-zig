pub const CatalogItemStatus = enum {
    available,
    discontinued,

    pub const json_field_names = .{
        .available = "AVAILABLE",
        .discontinued = "DISCONTINUED",
    };
};
