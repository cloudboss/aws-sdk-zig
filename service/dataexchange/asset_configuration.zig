const Tag = @import("tag.zig").Tag;

/// The configuration for the asset, which can include tags.
pub const AssetConfiguration = struct {
    /// The tags to be applied to assets created by the job.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .tags = "Tags",
    };
};
