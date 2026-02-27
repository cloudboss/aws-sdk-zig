pub const DefaultPoliciesTypeValues = enum {
    volume,
    instance,
    all,

    pub const json_field_names = .{
        .volume = "VOLUME",
        .instance = "INSTANCE",
        .all = "ALL",
    };
};
