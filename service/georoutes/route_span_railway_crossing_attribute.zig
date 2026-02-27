pub const RouteSpanRailwayCrossingAttribute = enum {
    protected,
    unprotected,

    pub const json_field_names = .{
        .protected = "PROTECTED",
        .unprotected = "UNPROTECTED",
    };
};
