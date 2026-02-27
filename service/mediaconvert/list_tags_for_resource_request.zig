pub const ListTagsForResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the resource that you want to list tags
    /// for. To get the ARN, send a GET request with the resource name.
    arn: []const u8,

    pub const json_field_names = .{
        .arn = "Arn",
    };
};
