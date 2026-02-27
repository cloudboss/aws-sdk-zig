pub const ListTagsForResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the data store to which tags are being
    /// added.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceARN",
    };
};
