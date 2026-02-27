/// Returns information about errors in a
/// BatchAssociateApprovalRuleTemplateWithRepositories operation.
pub const BatchAssociateApprovalRuleTemplateWithRepositoriesError = struct {
    /// An error code that specifies whether the repository name was not valid or
    /// not found.
    error_code: ?[]const u8,

    /// An error message that provides details about why the repository name was not
    /// found or not valid.
    error_message: ?[]const u8,

    /// The name of the repository where the association was not made.
    repository_name: ?[]const u8,

    pub const json_field_names = .{
        .error_code = "errorCode",
        .error_message = "errorMessage",
        .repository_name = "repositoryName",
    };
};
