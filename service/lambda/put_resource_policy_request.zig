pub const PutResourcePolicyRequest = struct {
    /// The policy document you want to add to your Lambda resource. This is
    /// formatted as a JSON string.
    ///
    /// For more information, see [Working with resource-based policies in
    /// Lambda](https://docs.aws.amazon.com/lambda/latest/dg/access-control-resource-based.html) in the *Lambda Developer Guide*.
    policy: []const u8,

    /// The Amazon Resource Name (ARN) of the Lambda resource you want to add the
    /// policy to. You can use a qualified or an unqualified ARN. The value must be
    /// a complete ARN, and the operation does not accept wildcard characters.
    resource_arn: []const u8,

    /// The revision ID that the existing policy must match for the replacement to
    /// proceed. If the revision ID doesn't match, the operation fails with a
    /// `PreconditionFailedException` error. To retrieve the current revision ID,
    /// use the GetResourcePolicy operation.
    revision_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .policy = "Policy",
        .resource_arn = "ResourceArn",
        .revision_id = "RevisionId",
    };
};
