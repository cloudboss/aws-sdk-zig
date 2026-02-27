const aws = @import("aws");

pub const TagResourceRequest = struct {
    /// The `GraphqlApi` Amazon Resource Name (ARN).
    resource_arn: []const u8,

    /// A `TagMap` object.
    tags: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tags = "tags",
    };
};
