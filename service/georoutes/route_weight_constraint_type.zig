pub const RouteWeightConstraintType = enum {
    current,
    gross,
    unknown,

    pub const json_field_names = .{
        .current = "CURRENT",
        .gross = "GROSS",
        .unknown = "UNKNOWN",
    };
};
