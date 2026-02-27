pub const FilterStatus = enum {
    valid,
    invalid,

    pub const json_field_names = .{
        .valid = "VALID",
        .invalid = "INVALID",
    };
};
