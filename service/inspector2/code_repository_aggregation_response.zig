const SeverityCounts = @import("severity_counts.zig").SeverityCounts;

/// A response that contains the results of a finding aggregation by code
/// repository.
pub const CodeRepositoryAggregationResponse = struct {
    /// The Amazon Web Services account ID associated with the code repository.
    account_id: ?[]const u8 = null,

    /// The number of active findings that have an exploit available for the code
    /// repository.
    exploit_available_active_findings_count: ?i64 = null,

    /// The number of active findings that have a fix available for the code
    /// repository.
    fix_available_active_findings_count: ?i64 = null,

    /// The names of the projects associated with the code repository.
    project_names: []const u8,

    /// The type of repository provider for the code repository.
    provider_type: ?[]const u8 = null,

    /// The resource ID of the code repository.
    resource_id: ?[]const u8 = null,

    severity_counts: ?SeverityCounts = null,

    pub const json_field_names = .{
        .account_id = "accountId",
        .exploit_available_active_findings_count = "exploitAvailableActiveFindingsCount",
        .fix_available_active_findings_count = "fixAvailableActiveFindingsCount",
        .project_names = "projectNames",
        .provider_type = "providerType",
        .resource_id = "resourceId",
        .severity_counts = "severityCounts",
    };
};
