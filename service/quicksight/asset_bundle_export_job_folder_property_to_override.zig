pub const AssetBundleExportJobFolderPropertyToOverride = enum {
    name,
    parent_folder_arn,

    pub const json_field_names = .{
        .name = "NAME",
        .parent_folder_arn = "PARENT_FOLDER_ARN",
    };
};
