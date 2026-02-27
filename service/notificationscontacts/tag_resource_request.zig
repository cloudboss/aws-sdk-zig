const aws = @import("aws");

pub const TagResourceRequest = struct {
    /// The ARN of the configuration.
    arn: []const u8,

    /// A list of tags to apply to the configuration.
    tags: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .arn = "arn",
        .tags = "tags",
    };
};
