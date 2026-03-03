pub const DeleteResourcePolicyRequest = struct {
    /// The identifier of the revision to edit. If this ID doesn't match the
    /// current revision number, Amazon Lex returns an exception
    ///
    /// If you don't specify a revision ID, Amazon Lex will delete the current
    /// policy.
    expected_revision_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the bot or bot alias that has the
    /// resource policy attached.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .expected_revision_id = "expectedRevisionId",
        .resource_arn = "resourceArn",
    };
};
