/// Represents contact information for a person or role associated with the
/// procurement portal preference.
pub const Contact = struct {
    /// The email address of the contact person or role.
    email: ?[]const u8,

    /// The name of the contact person or role.
    name: ?[]const u8,

    pub const json_field_names = .{
        .email = "Email",
        .name = "Name",
    };
};
