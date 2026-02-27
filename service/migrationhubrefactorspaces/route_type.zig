pub const RouteType = enum {
    default,
    uri_path,

    pub const json_field_names = .{
        .default = "DEFAULT",
        .uri_path = "URI_PATH",
    };
};
