const LFTagPair = @import("lf_tag_pair.zig").LFTagPair;

/// A structure containing the name of a column resource and the LF-tags
/// attached to it.
pub const ColumnLFTag = struct {
    /// The LF-tags attached to a column resource.
    lf_tags: ?[]const LFTagPair = null,

    /// The name of a column resource.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .lf_tags = "LFTags",
        .name = "Name",
    };
};
