pub const ListTagsForResourceRequest = struct {
    /// Specify the `resourceArn` for the resource whose tags to display.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
    };
};
