const aws = @import("aws");

pub const TagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the bot, bot alias, or bot channel
    /// to tag.
    resource_arn: []const u8,

    /// A list of tag keys to add to the resource. If a tag key already
    /// exists, the existing value is replaced with the new value.
    tags: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .resource_arn = "resourceARN",
        .tags = "tags",
    };
};
