pub const ResourceTypeForTagging = enum {
    document,
    managed_instance,
    maintenance_window,
    parameter,
    patch_baseline,
    ops_item,
    opsmetadata,
    automation,
    association,

    pub const json_field_names = .{
        .document = "DOCUMENT",
        .managed_instance = "MANAGED_INSTANCE",
        .maintenance_window = "MAINTENANCE_WINDOW",
        .parameter = "PARAMETER",
        .patch_baseline = "PATCH_BASELINE",
        .ops_item = "OPS_ITEM",
        .opsmetadata = "OPSMETADATA",
        .automation = "AUTOMATION",
        .association = "ASSOCIATION",
    };
};
