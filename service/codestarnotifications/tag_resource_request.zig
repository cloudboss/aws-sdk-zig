const aws = @import("aws");

pub const TagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the notification rule to tag.
    arn: []const u8,

    /// The list of tags to associate with the resource. Tag key names cannot start
    /// with "`aws`".
    tags: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .arn = "Arn",
        .tags = "Tags",
    };
};
