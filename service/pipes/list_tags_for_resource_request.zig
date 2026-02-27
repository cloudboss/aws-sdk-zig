pub const ListTagsForResourceRequest = struct {
    /// The ARN of the pipe for which you want to view tags.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
    };
};
