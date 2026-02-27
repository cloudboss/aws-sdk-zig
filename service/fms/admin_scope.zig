const AccountScope = @import("account_scope.zig").AccountScope;
const OrganizationalUnitScope = @import("organizational_unit_scope.zig").OrganizationalUnitScope;
const PolicyTypeScope = @import("policy_type_scope.zig").PolicyTypeScope;
const RegionScope = @import("region_scope.zig").RegionScope;

/// Defines the resources that the Firewall Manager administrator can manage.
/// For more information about administrative scope, see [Managing Firewall
/// Manager
/// administrators](https://docs.aws.amazon.com/waf/latest/developerguide/fms-administrators.html) in the *Firewall Manager Developer Guide*.
pub const AdminScope = struct {
    /// Defines the accounts that the specified Firewall Manager administrator can
    /// apply policies to.
    account_scope: ?AccountScope,

    /// Defines the Organizations organizational units that the specified Firewall
    /// Manager administrator can apply policies to. For more information about OUs
    /// in Organizations, see [Managing organizational units (OUs)
    /// ](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_ous.html) in the *Organizations User Guide*.
    organizational_unit_scope: ?OrganizationalUnitScope,

    /// Defines the Firewall Manager policy types that the specified Firewall
    /// Manager administrator can create and manage.
    policy_type_scope: ?PolicyTypeScope,

    /// Defines the Amazon Web Services Regions that the specified Firewall Manager
    /// administrator can perform actions in.
    region_scope: ?RegionScope,

    pub const json_field_names = .{
        .account_scope = "AccountScope",
        .organizational_unit_scope = "OrganizationalUnitScope",
        .policy_type_scope = "PolicyTypeScope",
        .region_scope = "RegionScope",
    };
};
