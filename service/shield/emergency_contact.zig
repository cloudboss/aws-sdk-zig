/// Contact information that the SRT can use to contact you if you have
/// proactive engagement enabled, for escalations to the SRT and to initiate
/// proactive customer support.
pub const EmergencyContact = struct {
    /// Additional notes regarding the contact.
    contact_notes: ?[]const u8,

    /// The email address for the contact.
    email_address: []const u8,

    /// The phone number for the contact.
    phone_number: ?[]const u8,

    pub const json_field_names = .{
        .contact_notes = "ContactNotes",
        .email_address = "EmailAddress",
        .phone_number = "PhoneNumber",
    };
};
