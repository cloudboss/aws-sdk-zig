pub const ListTagsForResourceRequest = struct {
    /// To retrieve the next set of results, the `nextToken`
    /// value from a previous response; otherwise **null** to receive
    /// the first set of results.
    next_token: ?[]const u8 = null,

    /// The ARN of the resource.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .resource_arn = "resourceArn",
    };
};
