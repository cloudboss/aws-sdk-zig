pub const ListTagsForResourceRequest = struct {
    /// The ARN of the IAM Identity Center instance under which the operation will
    /// be executed. For more information about ARNs, see [Amazon Resource Names
    /// (ARNs) and Amazon Web Services Service
    /// Namespaces](/general/latest/gr/aws-arns-and-namespaces.html) in the *Amazon
    /// Web Services General Reference*.
    instance_arn: ?[]const u8 = null,

    /// The pagination token for the list API. Initially the value is null. Use the
    /// output of previous API calls to make subsequent calls.
    next_token: ?[]const u8 = null,

    /// The ARN of the resource with the tags to be listed.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .instance_arn = "InstanceArn",
        .next_token = "NextToken",
        .resource_arn = "ResourceArn",
    };
};
