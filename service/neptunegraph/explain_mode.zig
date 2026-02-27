pub const ExplainMode = enum {
    static,
    details,

    pub const json_field_names = .{
        .static = "STATIC",
        .details = "DETAILS",
    };
};
