const Tag = @import("tag.zig").Tag;

/// An object that contains a list of tags to be assigned to a list of analysis
/// IDs.
pub const AssetBundleImportJobAnalysisOverrideTags = struct {
    /// A list of analysis IDs that you want to apply overrides to. You can use `*`
    /// to override all analyses in this asset bundle.
    analysis_ids: []const []const u8,

    /// A list of tags for the analyses that you want to apply overrides to.
    tags: []const Tag,

    pub const json_field_names = .{
        .analysis_ids = "AnalysisIds",
        .tags = "Tags",
    };
};
