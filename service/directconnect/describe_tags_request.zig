pub const DescribeTagsRequest = struct {
    /// The Amazon Resource Names (ARNs) of the resources.
    resource_arns: []const []const u8,

    pub const json_field_names = .{
        .resource_arns = "resourceArns",
    };
};
