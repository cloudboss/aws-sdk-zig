pub const VolumeStatus = enum {
    regular,
    contains_marketplace_product_codes,
    missing_volume_attributes,
    missing_volume_attributes_and_precheck_unavailable,
    pending,

    pub const json_field_names = .{
        .regular = "REGULAR",
        .contains_marketplace_product_codes = "CONTAINS_MARKETPLACE_PRODUCT_CODES",
        .missing_volume_attributes = "MISSING_VOLUME_ATTRIBUTES",
        .missing_volume_attributes_and_precheck_unavailable = "MISSING_VOLUME_ATTRIBUTES_AND_PRECHECK_UNAVAILABLE",
        .pending = "PENDING",
    };
};
