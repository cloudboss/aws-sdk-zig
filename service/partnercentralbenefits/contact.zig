/// Represents contact information for a partner representative.
pub const Contact = struct {
    /// The business title or role of the contact person within the organization.
    business_title: ?[]const u8,

    /// The email address of the contact person.
    email: ?[]const u8,

    /// The first name of the contact person.
    first_name: ?[]const u8,

    /// The last name of the contact person.
    last_name: ?[]const u8,

    /// The phone number of the contact person.
    phone: ?[]const u8,

    pub const json_field_names = .{
        .business_title = "BusinessTitle",
        .email = "Email",
        .first_name = "FirstName",
        .last_name = "LastName",
        .phone = "Phone",
    };
};
