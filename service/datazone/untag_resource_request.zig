pub const UntagResourceRequest = struct {
    /// The ARN of the resource to be untagged in Amazon DataZone.
    resource_arn: []const u8,

    /// Specifies the tag keys for the `UntagResource` action.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tag_keys = "tagKeys",
    };
};
