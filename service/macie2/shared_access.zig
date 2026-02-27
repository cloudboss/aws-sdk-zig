pub const SharedAccess = enum {
    external,
    internal,
    not_shared,
    unknown,

    pub const json_field_names = .{
        .external = "EXTERNAL",
        .internal = "INTERNAL",
        .not_shared = "NOT_SHARED",
        .unknown = "UNKNOWN",
    };
};
