const aws = @import("aws");

pub const TagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the resource.
    resource_arn: []const u8,

    /// A map of key-value pairs that specifies the tags to associate with the
    /// resource.
    ///
    /// A resource can have a maximum of 50 tags. Each tag consists of a tag key and
    /// an associated tag value. The maximum length of a tag key is 128 characters.
    /// The maximum length of a tag value is 256 characters.
    tags: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tags = "tags",
    };
};
