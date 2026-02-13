pub const PatchProperty = enum {
    product,
    patch_product_family,
    patch_classification,
    patch_msrc_severity,
    patch_priority,
    patch_severity,

    pub const json_field_names = .{
        .product = "Product",
        .patch_product_family = "PatchProductFamily",
        .patch_classification = "PatchClassification",
        .patch_msrc_severity = "PatchMsrcSeverity",
        .patch_priority = "PatchPriority",
        .patch_severity = "PatchSeverity",
    };
};
