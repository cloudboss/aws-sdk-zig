pub const ListTagsForResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the resource for which you want to
    /// retrieve tags.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
    };
};
