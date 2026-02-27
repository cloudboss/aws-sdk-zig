pub const ListTagsForResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the resource whose tags should be listed.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceARN",
    };
};
