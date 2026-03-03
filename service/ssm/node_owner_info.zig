/// Information about ownership of a managed node.
pub const NodeOwnerInfo = struct {
    /// The ID of the Amazon Web Services account that owns the managed node.
    account_id: ?[]const u8 = null,

    /// The ID of the organization unit (OU) that the account is part of.
    organizational_unit_id: ?[]const u8 = null,

    /// The path for the organizational unit (OU) that owns the managed node. The
    /// path for the OU is
    /// built using the IDs of the organization, root, and all OUs in the path down
    /// to and including the
    /// OU. For example:
    ///
    /// `o-a1b2c3d4e5/r-f6g7h8i9j0example/ou-ghi0-awsccccc/ou-jkl0-awsddddd/`
    organizational_unit_path: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .organizational_unit_id = "OrganizationalUnitId",
        .organizational_unit_path = "OrganizationalUnitPath",
    };
};
