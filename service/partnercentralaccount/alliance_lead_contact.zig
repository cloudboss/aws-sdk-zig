/// Contains contact information for the primary alliance lead responsible for
/// partnership activities.
pub const AllianceLeadContact = struct {
    /// The business title or role of the alliance lead contact person.
    business_title: []const u8,

    /// The email address of the alliance lead contact person.
    email: []const u8,

    /// The first name of the alliance lead contact person.
    first_name: []const u8,

    /// The last name of the alliance lead contact person.
    last_name: []const u8,

    pub const json_field_names = .{
        .business_title = "BusinessTitle",
        .email = "Email",
        .first_name = "FirstName",
        .last_name = "LastName",
    };
};
