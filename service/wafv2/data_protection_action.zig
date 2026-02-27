pub const DataProtectionAction = enum {
    substitution,
    hash,

    pub const json_field_names = .{
        .substitution = "SUBSTITUTION",
        .hash = "HASH",
    };
};
