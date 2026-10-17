const AwsOrganizationScope = @import("aws_organization_scope.zig").AwsOrganizationScope;

/// Defines the data boundary for a findings export. Scopes determine which
/// organizational units or organizations to retrieve data from.
///
/// Only a delegated administrator can use this structure. If a delegated
/// administrator omits it, the export covers the entire organization; any other
/// caller exports only findings from its own account.
pub const ExportScopes = struct {
    /// A list of Organizations scopes to include in the export. Each entry in the
    /// list specifies an organization or organizational unit to include for the
    /// delegated administrator's account. If the list specifies multiple entries,
    /// the entries are combined using OR logic.
    aws_organizations: ?[]const AwsOrganizationScope = null,

    pub const json_field_names = .{
        .aws_organizations = "AwsOrganizations",
    };
};
