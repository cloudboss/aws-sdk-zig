pub const ListTagsForResourceRequest = struct {
    /// The ARN of the resource the tag is assigned to.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
    };
};
