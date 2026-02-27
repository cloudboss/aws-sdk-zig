const aws = @import("aws");

pub const TagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the resource to add tags to.
    arn: []const u8,

    /// The tags to add to the resource.
    tags: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .arn = "arn",
        .tags = "tags",
    };
};
