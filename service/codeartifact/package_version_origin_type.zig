pub const PackageVersionOriginType = enum {
    internal,
    external,
    unknown,

    pub const json_field_names = .{
        .internal = "INTERNAL",
        .external = "EXTERNAL",
        .unknown = "UNKNOWN",
    };
};
