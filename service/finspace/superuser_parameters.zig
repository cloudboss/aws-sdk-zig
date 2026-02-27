/// Configuration information for the superuser.
pub const SuperuserParameters = struct {
    /// The email address of the superuser.
    email_address: []const u8,

    /// The first name of the superuser.
    first_name: []const u8,

    /// The last name of the superuser.
    last_name: []const u8,

    pub const json_field_names = .{
        .email_address = "emailAddress",
        .first_name = "firstName",
        .last_name = "lastName",
    };
};
