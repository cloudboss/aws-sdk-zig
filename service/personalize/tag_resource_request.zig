const Tag = @import("tag.zig").Tag;

pub const TagResourceRequest = struct {
    /// The resource's Amazon Resource Name (ARN).
    resource_arn: []const u8,

    /// Tags to apply to the resource. For more information see [Tagging Amazon
    /// Personalize
    /// resources](https://docs.aws.amazon.com/personalize/latest/dg/tagging-resources.html).
    tags: []const Tag,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tags = "tags",
    };
};
