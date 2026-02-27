/// The request parameters of ListTagsForResource.
pub const ListTagsForResourceRequest = struct {
    /// The Amazon Web Services Supply chain resource ARN that needs tags to be
    /// listed.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
    };
};
