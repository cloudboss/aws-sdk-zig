/// A set of AWS accounts and organizational units.
pub const AccountSet = struct {
    /// The list of AWS account IDs.
    account_ids: ?[]const []const u8 = null,

    /// The AWS Organizations organizational units (OUs) in the selection.
    organizational_units: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .account_ids = "accountIds",
        .organizational_units = "organizationalUnits",
    };
};
