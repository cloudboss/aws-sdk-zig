const Tag = @import("tag.zig").Tag;

/// An object that contains a list of tags to be assigned to a list of theme
/// IDs.
pub const AssetBundleImportJobThemeOverrideTags = struct {
    /// A list of tags for the themes that you want to apply overrides to.
    tags: []const Tag,

    /// A list of theme IDs that you want to apply overrides to. You can use `*` to
    /// override all themes in this asset bundle.
    theme_ids: []const []const u8,

    pub const json_field_names = .{
        .tags = "Tags",
        .theme_ids = "ThemeIds",
    };
};
