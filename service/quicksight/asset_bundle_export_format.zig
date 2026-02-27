pub const AssetBundleExportFormat = enum {
    cloudformation_json,
    quicksight_json,

    pub const json_field_names = .{
        .cloudformation_json = "CLOUDFORMATION_JSON",
        .quicksight_json = "QUICKSIGHT_JSON",
    };
};
