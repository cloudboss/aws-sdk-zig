pub const UntagResourceRequest = struct {
    /// The ARN of the resource whose tags you want to remove.
    resource_arn: []const u8,

    /// The keys of those tags which you want to remove.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tag_keys = "tagKeys",
    };
};
