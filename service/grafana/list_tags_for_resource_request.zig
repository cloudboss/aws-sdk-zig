pub const ListTagsForResourceRequest = struct {
    /// The ARN of the resource the list of tags are associated with.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
    };
};
