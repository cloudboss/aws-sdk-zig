pub const ImportType = enum {
    new_key_material,
    existing_key_material,

    pub const json_field_names = .{
        .new_key_material = "NEW_KEY_MATERIAL",
        .existing_key_material = "EXISTING_KEY_MATERIAL",
    };
};
