const S3Tag = @import("s3_tag.zig").S3Tag;

pub const Tagging = struct {
    /// A collection for a set of tags.
    tag_set: []const S3Tag,
};
