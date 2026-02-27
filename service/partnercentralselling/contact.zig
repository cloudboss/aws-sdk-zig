/// An object that contains a `Customer Partner`'s contact details.
pub const Contact = struct {
    /// The partner contact's title (job title or role) associated with the
    /// `Opportunity`. `BusinessTitle` supports either `PartnerAccountManager` or
    /// `OpportunityOwner`.
    business_title: ?[]const u8,

    /// The contact's email address associated with the `Opportunity`.
    email: ?[]const u8,

    /// The contact's first name associated with the `Opportunity`.
    first_name: ?[]const u8,

    /// The contact's last name associated with the `Opportunity`.
    last_name: ?[]const u8,

    /// The contact's phone number associated with the `Opportunity`.
    phone: ?[]const u8,

    pub const json_field_names = .{
        .business_title = "BusinessTitle",
        .email = "Email",
        .first_name = "FirstName",
        .last_name = "LastName",
        .phone = "Phone",
    };
};
