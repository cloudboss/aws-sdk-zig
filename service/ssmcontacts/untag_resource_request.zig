pub const UntagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the contact or escalation plan.
    resource_arn: []const u8,

    /// The key of the tag that you want to remove.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceARN",
        .tag_keys = "TagKeys",
    };
};
