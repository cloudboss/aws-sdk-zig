const aws = @import("aws");

pub const TagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the Amazon Web Services resource to which
    /// to add the specified
    /// metadata tags.
    resource_arn: []const u8,

    /// The metadata tags to assign to the Amazon Web Services resource. Tags are
    /// formatted as key value pairs.
    tags: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tags = "tags",
    };
};
