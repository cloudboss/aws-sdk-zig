const Tag = @import("tag.zig").Tag;

/// An object that contains a list of tags to be assigned to a list of folder
/// IDs.
pub const AssetBundleImportJobFolderOverrideTags = struct {
    /// A list of folder IDs that you want to apply overrides to. You can use `*` to
    /// override all folders in this asset bundle.
    folder_ids: []const []const u8,

    /// A list of tags for the folders that you want to apply overrides to.
    tags: []const Tag,

    pub const json_field_names = .{
        .folder_ids = "FolderIds",
        .tags = "Tags",
    };
};
