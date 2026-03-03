/// Policy statement applied to the application.
pub const ApplicationPolicyStatement = struct {
    /// For the list of actions supported for this operation, see [Application
    /// Permissions](https://docs.aws.amazon.com/serverlessrepo/latest/devguide/access-control-resource-based.html#application-permissions).
    actions: []const []const u8,

    /// An array of PrinciplalOrgIDs, which corresponds to AWS IAM
    /// [aws:PrincipalOrgID](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_condition-keys.html#principal-org-id) global condition key.
    principal_org_i_ds: ?[]const []const u8 = null,

    /// An array of AWS account IDs, or * to make the application public.
    principals: []const []const u8,

    /// A unique ID for the statement.
    statement_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .actions = "Actions",
        .principal_org_i_ds = "PrincipalOrgIDs",
        .principals = "Principals",
        .statement_id = "StatementId",
    };
};
