const aws = @import("aws");

pub const TagResourceRequest = struct {
    /// The Amazon Resource Name (ARN)
    arn: []const u8,

    /// A map of of key-value pairs that represent tags on a resource. Tags are used
    /// to organize, track, or control access for this resource.
    tags: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .arn = "arn",
        .tags = "tags",
    };
};
