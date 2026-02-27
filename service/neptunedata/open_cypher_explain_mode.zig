pub const OpenCypherExplainMode = enum {
    static,
    dynamic,
    details,

    pub const json_field_names = .{
        .static = "STATIC",
        .dynamic = "DYNAMIC",
        .details = "DETAILS",
    };
};
