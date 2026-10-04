pub const DeleteResourcePolicyRequest = struct {
    /// The Amazon Resource Name (ARN) of the Lambda resource you want to delete the
    /// policy from. You can use a qualified or an unqualified ARN. The value must
    /// be a complete ARN, and the operation does not accept wildcard characters.
    resource_arn: []const u8,

    /// The revision ID that the existing policy must match for the deletion to
    /// proceed. If the revision ID doesn't match, the operation fails with a
    /// `PreconditionFailedException` error. To retrieve the current revision ID,
    /// use the GetResourcePolicy operation.
    revision_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .revision_id = "RevisionId",
    };
};
