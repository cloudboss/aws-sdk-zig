pub const Select = enum {
    all_attributes,
    all_projected_attributes,
    specific_attributes,
    count,

    pub const json_field_names = .{
        .all_attributes = "ALL_ATTRIBUTES",
        .all_projected_attributes = "ALL_PROJECTED_ATTRIBUTES",
        .specific_attributes = "SPECIFIC_ATTRIBUTES",
        .count = "COUNT",
    };
};
