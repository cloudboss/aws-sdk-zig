const Tag = @import("tag.zig").Tag;

/// An object that contains a list of tags to be assigned to a list of data
/// source
/// IDs.
pub const AssetBundleImportJobDataSourceOverrideTags = struct {
    /// A list of data source IDs that you want to apply overrides to. You can use
    /// `*` to override all data sources in this asset bundle.
    data_source_ids: []const []const u8,

    /// A list of tags for the data source that you want to apply overrides to.
    tags: []const Tag,

    pub const json_field_names = .{
        .data_source_ids = "DataSourceIds",
        .tags = "Tags",
    };
};
