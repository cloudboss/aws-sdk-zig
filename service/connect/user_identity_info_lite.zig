/// The user's first name and last name.
pub const UserIdentityInfoLite = struct {
    /// The user's first name.
    first_name: ?[]const u8 = null,

    /// The user's last name.
    last_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .first_name = "FirstName",
        .last_name = "LastName",
    };
};
