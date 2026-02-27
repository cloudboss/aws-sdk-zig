const AlternateContactType = @import("alternate_contact_type.zig").AlternateContactType;

/// A structure that contains the details of an alternate contact associated
/// with an Amazon Web Services account
pub const AlternateContact = struct {
    /// The type of alternate contact.
    alternate_contact_type: ?AlternateContactType,

    /// The email address associated with this alternate contact.
    email_address: ?[]const u8,

    /// The name associated with this alternate contact.
    name: ?[]const u8,

    /// The phone number associated with this alternate contact.
    phone_number: ?[]const u8,

    /// The title associated with this alternate contact.
    title: ?[]const u8,

    pub const json_field_names = .{
        .alternate_contact_type = "AlternateContactType",
        .email_address = "EmailAddress",
        .name = "Name",
        .phone_number = "PhoneNumber",
        .title = "Title",
    };
};
