pub const ListTagsForResourceRequest = struct {
    /// The ARN of the ACM resource for which to list tags.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
    };
};
