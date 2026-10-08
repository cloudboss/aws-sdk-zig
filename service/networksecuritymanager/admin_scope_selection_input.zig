/// A selection of accounts and organizational units. This is the input form,
/// which uses account and organizational unit IDs.
pub const AdminScopeSelectionInput = struct {
    /// The AWS accounts in the selection.
    accounts: ?[]const []const u8 = null,

    /// The AWS Organizations organizational units (OUs) in the selection.
    organizational_units: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .accounts = "accounts",
        .organizational_units = "organizationalUnits",
    };
};
