const aws = @import("aws");

pub const TagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) that identifies the resource to list the tags
    /// for. Currently, the supported resources are Amazon EMR Serverless
    /// applications and job runs.
    resource_arn: []const u8,

    /// The tags to add to the resource. A tag is an array of key-value pairs.
    tags: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tags = "tags",
    };
};
