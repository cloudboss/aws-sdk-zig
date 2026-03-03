pub const UntagResourceRequest = struct {
    /// The ARN of the IAM Identity Center instance under which the operation will
    /// be executed. For more information about ARNs, see [Amazon Resource Names
    /// (ARNs) and Amazon Web Services Service
    /// Namespaces](/general/latest/gr/aws-arns-and-namespaces.html) in the *Amazon
    /// Web Services General Reference*.
    instance_arn: ?[]const u8 = null,

    /// The ARN of the resource with the tags to be listed.
    resource_arn: []const u8,

    /// The keys of tags that are attached to the resource.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .instance_arn = "InstanceArn",
        .resource_arn = "ResourceArn",
        .tag_keys = "TagKeys",
    };
};
