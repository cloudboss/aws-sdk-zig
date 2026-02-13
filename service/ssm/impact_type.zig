pub const ImpactType = enum {
    mutating,
    non_mutating,
    undetermined,

    pub const json_field_names = .{
        .mutating = "MUTATING",
        .non_mutating = "NON_MUTATING",
        .undetermined = "UNDETERMINED",
    };
};
