const aws = @import("aws");

pub const TagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) that uniquely identifies the resource.
    ///
    /// This is the resource that will have the indicated tags.
    resource_arn: []const u8,

    /// Required tags to include. A tag is a key-value pair you can use to manage,
    /// filter, and search for your resources. Allowed characters include UTF-8
    /// letters, numbers, spaces, and the following characters: + - = . _ : /.
    tags: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tags = "Tags",
    };
};
