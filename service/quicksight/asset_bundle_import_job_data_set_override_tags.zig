const Tag = @import("tag.zig").Tag;

/// An object that contains a list of tags to be assigned to a list of dataset
/// IDs.
pub const AssetBundleImportJobDataSetOverrideTags = struct {
    /// A list of dataset IDs that you want to apply overrides to. You can use `*`
    /// to
    /// override all datasets in this asset bundle.
    data_set_ids: []const []const u8,

    /// A list of tags for the datasets that you want to apply overrides to.
    tags: []const Tag,

    pub const json_field_names = .{
        .data_set_ids = "DataSetIds",
        .tags = "Tags",
    };
};
