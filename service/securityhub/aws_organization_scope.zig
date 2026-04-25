/// Specifies an Organizations scope. Data from the specified organization or
/// organizational unit is included in the response.
///
/// To scope to a specific organizational unit, provide `OrganizationalUnitId`.
/// You can optionally include `OrganizationId`. If you omit `OrganizationId`,
/// Security Hub uses the caller's organization ID.
/// To scope to the delegated administrator's entire organization, provide only
/// `OrganizationId`.
///
/// The organization ID and organizational unit must belong to the delegated
/// administrator's own organization.
/// Each request must use one scoping approach: either scope to the entire
/// organization by providing an `AwsOrganizationScope` entry with only
/// `OrganizationId`, or scope to specific organizational units by providing
/// `AwsOrganizationScope` entries with `OrganizationalUnitId`. You can't
/// combine both approaches in the same request.
pub const AwsOrganizationScope = struct {
    /// The unique identifier (ID) of the organizational unit (OU) (for example,
    /// `ou-ab12-cd345678`). The OU must exist within the delegated administrator's
    /// own organization. When specified, the results include only data from
    /// accounts in this OU.
    organizational_unit_id: ?[]const u8 = null,

    /// The unique identifier (ID) of the organization (for example,
    /// `o-abcd1234567890`). The organization must be the delegated administrator's
    /// own organization.
    /// If you omit this value and provide `OrganizationalUnitId`, Security Hub uses
    /// the caller's organization ID.
    organization_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .organizational_unit_id = "OrganizationalUnitId",
        .organization_id = "OrganizationId",
    };
};
