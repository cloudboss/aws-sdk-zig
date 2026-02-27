pub const ListTagsForResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the resource that you are interested in.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
    };
};
