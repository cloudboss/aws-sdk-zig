pub const IncludeKeyMaterial = enum {
    all_key_material,
    rotations_only,

    pub const json_field_names = .{
        .all_key_material = "ALL_KEY_MATERIAL",
        .rotations_only = "ROTATIONS_ONLY",
    };
};
