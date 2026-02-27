const aws = @import("aws");

pub const TagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the resource that you want to tag. To get
    /// the ARN, send a GET request with the resource name.
    arn: []const u8,

    /// The tags that you want to add to the resource. You can tag resources with a
    /// key-value pair or with only a key.
    tags: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .arn = "Arn",
        .tags = "Tags",
    };
};
