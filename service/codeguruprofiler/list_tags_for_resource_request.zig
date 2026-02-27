pub const ListTagsForResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the resource that contains the tags to
    /// return.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
    };
};
