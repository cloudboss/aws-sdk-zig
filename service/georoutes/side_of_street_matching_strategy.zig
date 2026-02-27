pub const SideOfStreetMatchingStrategy = enum {
    any_street,
    divided_street_only,

    pub const json_field_names = .{
        .any_street = "ANY_STREET",
        .divided_street_only = "DIVIDED_STREET_ONLY",
    };
};
