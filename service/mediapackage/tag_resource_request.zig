const aws = @import("aws");

pub const TagResourceRequest = struct {
    resource_arn: []const u8,

    tags: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tags = "Tags",
    };
};
