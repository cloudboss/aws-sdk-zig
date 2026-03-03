/// This structure contains information about the cross-account configuration in
/// the account.
pub const CrossAccountConfiguration = struct {
    /// The ARN of an existing role which will be used to do investigations on your
    /// behalf.
    source_role_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .source_role_arn = "sourceRoleArn",
    };
};
