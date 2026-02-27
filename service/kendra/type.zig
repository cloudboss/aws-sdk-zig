pub const Type = enum {
    saas,
    on_premise,

    pub const json_field_names = .{
        .saas = "SAAS",
        .on_premise = "ON_PREMISE",
    };
};
