pub const ListTagsForResourceRequest = struct {
    /// ARN of a resource.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
    };
};
