/// Configuration for IAM-based authentication flow for the Operator App.
pub const IamAuthConfiguration = struct {
    /// The timestamp when the Operator App IAM auth flow was enabled.
    created_at: i64,

    /// The IAM role end users assume to access AIDevOps APIs
    operator_app_role_arn: []const u8,

    /// The timestamp when the Operator App IAM auth flow was updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .operator_app_role_arn = "operatorAppRoleArn",
        .updated_at = "updatedAt",
    };
};
