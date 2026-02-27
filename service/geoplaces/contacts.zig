const ContactDetails = @import("contact_details.zig").ContactDetails;

/// A list of potential contact methods for the result/place.
pub const Contacts = struct {
    /// List of emails for contacts of the result.
    emails: ?[]const ContactDetails,

    /// List of fax addresses for the result contact.
    faxes: ?[]const ContactDetails,

    /// List of phone numbers for the results contact.
    phones: ?[]const ContactDetails,

    /// List of website URLs that belong to the result.
    websites: ?[]const ContactDetails,

    pub const json_field_names = .{
        .emails = "Emails",
        .faxes = "Faxes",
        .phones = "Phones",
        .websites = "Websites",
    };
};
