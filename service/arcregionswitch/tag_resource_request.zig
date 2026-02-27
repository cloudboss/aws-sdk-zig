const aws = @import("aws");

pub const TagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) for a tag that you add to a resource.
    arn: []const u8,

    /// Tags that you add to a resource. You can add a maximum of 50 tags in Region
    /// switch.
    tags: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .arn = "arn",
        .tags = "tags",
    };
};
