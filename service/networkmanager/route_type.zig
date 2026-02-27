pub const RouteType = enum {
    propagated,
    static,

    pub const json_field_names = .{
        .propagated = "PROPAGATED",
        .static = "STATIC",
    };
};
