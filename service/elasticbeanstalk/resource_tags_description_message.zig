const Tag = @import("tag.zig").Tag;

pub const ResourceTagsDescriptionMessage = struct {
    /// The Amazon Resource Name (ARN) of the resource for which a tag list was
    /// requested.
    resource_arn: ?[]const u8 = null,

    /// A list of tag key-value pairs.
    resource_tags: ?[]const Tag = null,
};
