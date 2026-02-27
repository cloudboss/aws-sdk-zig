pub const ListTagsForResourceRequest = struct {
    /// The ARN of the resource whose tags you want to list.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
    };
};
