pub const ListTagsForResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the accelerator to list tags for. An ARN
    /// uniquely identifies an accelerator.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
    };
};
