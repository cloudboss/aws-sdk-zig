const Tag = @import("tag.zig").Tag;

/// The request object for the `TagResource` operation.
pub const TagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the Amazon FSx resource that you want to
    /// tag.
    resource_arn: []const u8,

    /// A list of tags for the resource. If a tag with a given key already exists,
    /// the
    /// value is replaced by the one specified in this parameter.
    tags: []const Tag,

    pub const json_field_names = .{
        .resource_arn = "ResourceARN",
        .tags = "Tags",
    };
};
