const Tag = @import("tag.zig").Tag;

pub const TagResourceRequest = struct {
    /// Identifies the Timestream resource to which tags should be added. This value
    /// is an
    /// Amazon Resource Name (ARN).
    resource_arn: []const u8,

    /// The tags to be assigned to the Timestream resource.
    tags: []const Tag,

    pub const json_field_names = .{
        .resource_arn = "ResourceARN",
        .tags = "Tags",
    };
};
