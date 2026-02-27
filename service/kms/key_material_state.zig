pub const KeyMaterialState = enum {
    non_current,
    current,
    pending_rotation,
    pending_multi_region_import_and_rotation,

    pub const json_field_names = .{
        .non_current = "NON_CURRENT",
        .current = "CURRENT",
        .pending_rotation = "PENDING_ROTATION",
        .pending_multi_region_import_and_rotation = "PENDING_MULTI_REGION_IMPORT_AND_ROTATION",
    };
};
