pub const UntagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) that identifies the resource to list the tags
    /// for. Currently, the supported resources are Amazon EMR Serverless
    /// applications and job runs.
    resource_arn: []const u8,

    /// The keys of the tags to be removed.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tag_keys = "tagKeys",
    };
};
