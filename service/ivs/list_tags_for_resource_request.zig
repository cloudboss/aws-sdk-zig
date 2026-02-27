pub const ListTagsForResourceRequest = struct {
    /// The ARN of the resource to be retrieved. The ARN must be URL-encoded.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
    };
};
