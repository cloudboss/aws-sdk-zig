const aws = @import("aws");

pub const TagResourceRequest = struct {
    /// The ARN of the Glue resource to which to add the tags. For more
    /// information about Glue resource ARNs, see the [Glue ARN string
    /// pattern](https://docs.aws.amazon.com/glue/latest/dg/aws-glue-api-common.html#aws-glue-api-regex-aws-glue-arn-id).
    resource_arn: []const u8,

    /// Tags to add to this resource.
    tags_to_add: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tags_to_add = "TagsToAdd",
    };
};
