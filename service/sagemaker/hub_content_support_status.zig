pub const HubContentSupportStatus = enum {
    supported,
    deprecated,
    restricted,

    pub const json_field_names = .{
        .supported = "SUPPORTED",
        .deprecated = "DEPRECATED",
        .restricted = "RESTRICTED",
    };
};
