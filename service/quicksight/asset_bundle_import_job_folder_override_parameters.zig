/// The override parameters for a single folder that is being imported.
pub const AssetBundleImportJobFolderOverrideParameters = struct {
    /// The ID of the folder that you want to apply overrides to.
    folder_id: []const u8,

    /// A new name for the folder.
    name: ?[]const u8 = null,

    /// A new parent folder arn. This change can only be applied if the import
    /// creates a brand
    /// new folder. Existing folders cannot be moved.
    parent_folder_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .folder_id = "FolderId",
        .name = "Name",
        .parent_folder_arn = "ParentFolderArn",
    };
};
