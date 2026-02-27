const aws = @import("aws");

pub const TagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) that identifies the MediaConnect resource to
    /// which to add tags.
    resource_arn: []const u8,

    /// A map from tag keys to values. Tag keys can have a maximum character length
    /// of 128 characters, and tag values can have a maximum length of 256
    /// characters.
    tags: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tags = "Tags",
    };
};
