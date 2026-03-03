/// An object that contains a lead contact's details associated with the
/// engagement. This provides contact information for individuals involved in
/// lead-related activities.
pub const LeadContact = struct {
    /// The lead contact's business title or job role associated with the
    /// engagement.
    business_title: []const u8,

    /// The lead contact's email address associated with the engagement.
    email: []const u8,

    /// The lead contact's first name associated with the engagement.
    first_name: []const u8,

    /// The lead contact's last name associated with the engagement.
    last_name: []const u8,

    /// The lead contact's phone number associated with the engagement.
    phone: ?[]const u8 = null,

    pub const json_field_names = .{
        .business_title = "BusinessTitle",
        .email = "Email",
        .first_name = "FirstName",
        .last_name = "LastName",
        .phone = "Phone",
    };
};
