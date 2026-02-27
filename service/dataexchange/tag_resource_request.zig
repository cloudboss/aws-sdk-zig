const aws = @import("aws");

pub const TagResourceRequest = struct {
    /// An Amazon Resource Name (ARN) that uniquely identifies an AWS resource.
    resource_arn: []const u8,

    /// A label that consists of a customer-defined key and an optional value.
    tags: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tags = "Tags",
    };
};
