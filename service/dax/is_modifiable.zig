pub const IsModifiable = enum {
    true,
    false,
    conditional,

    pub const json_field_names = .{
        .true = "TRUE",
        .false = "FALSE",
        .conditional = "CONDITIONAL",
    };
};
