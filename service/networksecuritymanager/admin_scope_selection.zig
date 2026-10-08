const AccountReference = @import("account_reference.zig").AccountReference;
const OrganizationalUnitReference = @import("organizational_unit_reference.zig").OrganizationalUnitReference;

/// A selection of accounts and organizational units. This is the reference
/// form, which includes display metadata.
pub const AdminScopeSelection = struct {
    /// The AWS accounts in the selection.
    accounts: ?[]const AccountReference = null,

    /// The AWS Organizations organizational units (OUs) in the selection.
    organizational_units: ?[]const OrganizationalUnitReference = null,

    pub const json_field_names = .{
        .accounts = "accounts",
        .organizational_units = "organizationalUnits",
    };
};
