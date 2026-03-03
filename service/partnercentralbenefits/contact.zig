/// Represents contact information for a partner representative.
pub const Contact = struct {
    /// The business title or role of the contact person within the organization.
    business_title: ?[]const u8 = null,

    /// The email address of the contact person.
    email: ?[]const u8 = null,

    /// The first name of the contact person.
    first_name: ?[]const u8 = null,

    /// The last name of the contact person.
    last_name: ?[]const u8 = null,

    /// The phone number of the contact person.
    phone: ?[]const u8 = null,

    pub const json_field_names = .{
        .business_title = "BusinessTitle",
        .email = "Email",
        .first_name = "FirstName",
        .last_name = "LastName",
        .phone = "Phone",
    };
};
