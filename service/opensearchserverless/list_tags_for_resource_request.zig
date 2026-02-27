pub const ListTagsForResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the resource. The resource must be active
    /// (not in the `DELETING` state), and must be owned by the account ID included
    /// in the request.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
    };
};
