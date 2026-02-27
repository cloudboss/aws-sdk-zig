/// A structure containing a subset of the fields of a user object from a
/// directory.
pub const UserSummary = struct {
    /// Indicates whether the user account is active.
    enabled: bool,

    /// The first name of the user.
    given_name: ?[]const u8,

    /// The name of the user.
    sam_account_name: []const u8,

    /// The unique security identifier (SID) of the user.
    sid: []const u8,

    /// The last name of the user.
    surname: ?[]const u8,

    pub const json_field_names = .{
        .enabled = "Enabled",
        .given_name = "GivenName",
        .sam_account_name = "SAMAccountName",
        .sid = "SID",
        .surname = "Surname",
    };
};
