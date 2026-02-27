const aws = @import("aws");

pub const TagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the resource to which you want to add
    /// tags.
    resource_arn: []const u8,

    /// A collection of labels, in the form of key:value pairs, that apply to this
    /// resource.
    tags: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tags = "tags",
    };
};
