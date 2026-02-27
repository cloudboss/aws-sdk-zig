const aws = @import("aws");

pub const TagResourceRequest = struct {
    /// The ARN of the pipe.
    resource_arn: []const u8,

    /// The list of key-value pairs associated with the pipe.
    tags: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tags = "tags",
    };
};
