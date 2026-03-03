const Tag = @import("tag.zig").Tag;

pub const TagResourceRequest = struct {
    /// The ARN of the IAM Identity Center instance under which the operation will
    /// be executed. For more information about ARNs, see [Amazon Resource Names
    /// (ARNs) and Amazon Web Services Service
    /// Namespaces](/general/latest/gr/aws-arns-and-namespaces.html) in the *Amazon
    /// Web Services General Reference*.
    instance_arn: ?[]const u8 = null,

    /// The ARN of the resource with the tags to be listed.
    resource_arn: []const u8,

    /// A set of key-value pairs that are used to manage the resource.
    tags: []const Tag,

    pub const json_field_names = .{
        .instance_arn = "InstanceArn",
        .resource_arn = "ResourceArn",
        .tags = "Tags",
    };
};
