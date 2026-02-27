pub const ListTagsForResourceRequest = struct {
    /// The Timestream resource with tags to be listed. This value is an Amazon
    /// Resource Name (ARN).
    resource_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceARN",
    };
};
