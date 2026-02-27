pub const ListTagsForResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the user pool that the tags are assigned
    /// to.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
    };
};
