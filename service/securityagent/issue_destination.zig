/// The destination for filing findings as issues in an integrated issue
/// tracker.
pub const IssueDestination = struct {
    /// The integration identifier for the issue-tracker provider.
    integration_id: []const u8,

    /// The identifier of the project the issues are filed under.
    project_key: []const u8,

    pub const json_field_names = .{
        .integration_id = "integrationId",
        .project_key = "projectKey",
    };
};
