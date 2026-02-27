pub const ListTagsForResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the given Amazon Translate resource you
    /// are querying.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
    };
};
