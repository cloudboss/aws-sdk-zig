pub const ExpirationModelType = enum {
    key_material_expires,
    key_material_does_not_expire,

    pub const json_field_names = .{
        .key_material_expires = "KEY_MATERIAL_EXPIRES",
        .key_material_does_not_expire = "KEY_MATERIAL_DOES_NOT_EXPIRE",
    };
};
