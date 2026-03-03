/// Defines the Organizations organizational units (OUs) that the specified
/// Firewall Manager administrator can apply policies to. For more information
/// about OUs in Organizations, see [Managing organizational units (OUs)
/// ](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_ous.html) in the *Organizations User Guide*.
pub const OrganizationalUnitScope = struct {
    /// A boolean value that indicates if the administrator can apply policies to
    /// all OUs within an organization. If true, the administrator can manage all
    /// OUs within the organization. You can either enable management of all OUs
    /// through this operation, or you can specify OUs to manage in
    /// `OrganizationalUnitScope$OrganizationalUnits`. You cannot specify both.
    all_organizational_units_enabled: bool = false,

    /// A boolean value that excludes the OUs in
    /// `OrganizationalUnitScope$OrganizationalUnits` from the administrator's
    /// scope. If true, the Firewall Manager administrator can apply policies to all
    /// OUs in the organization except for the OUs listed in
    /// `OrganizationalUnitScope$OrganizationalUnits`. You can either specify a list
    /// of OUs to exclude by `OrganizationalUnitScope$OrganizationalUnits`, or you
    /// can enable management of all OUs by
    /// `OrganizationalUnitScope$AllOrganizationalUnitsEnabled`. You cannot specify
    /// both.
    exclude_specified_organizational_units: bool = false,

    /// The list of OUs within the organization that the specified Firewall Manager
    /// administrator either can or cannot apply policies to, based on the value of
    /// `OrganizationalUnitScope$ExcludeSpecifiedOrganizationalUnits`. If
    /// `OrganizationalUnitScope$ExcludeSpecifiedOrganizationalUnits` is set to
    /// `true`, then the Firewall Manager administrator can apply policies to all
    /// OUs in the organization except for the OUs in this list. If
    /// `OrganizationalUnitScope$ExcludeSpecifiedOrganizationalUnits` is set to
    /// `false`, then the Firewall Manager administrator can only apply policies to
    /// the OUs in this list.
    organizational_units: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .all_organizational_units_enabled = "AllOrganizationalUnitsEnabled",
        .exclude_specified_organizational_units = "ExcludeSpecifiedOrganizationalUnits",
        .organizational_units = "OrganizationalUnits",
    };
};
