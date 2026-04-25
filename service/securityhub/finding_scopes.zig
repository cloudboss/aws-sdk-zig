const AwsOrganizationScope = @import("aws_organization_scope.zig").AwsOrganizationScope;

/// Defines the data boundary for a findings query. Scopes determine which
/// organizational units or organizations to retrieve data from.
pub const FindingScopes = struct {
    /// A list of Organizations scopes to include in the query results. Each entry
    /// in the list specifies an organization or organizational unit to include for
    /// the delegated administrator's account. If the list specifies multiple
    /// entries, the entries are combined using OR logic.
    aws_organizations: ?[]const AwsOrganizationScope = null,

    pub const json_field_names = .{
        .aws_organizations = "AwsOrganizations",
    };
};
