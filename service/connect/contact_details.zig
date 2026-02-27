/// A map of string key/value pairs that contain user-defined attributes which
/// are lightly typed within the contact.
/// This object is used only for task contacts.
pub const ContactDetails = struct {
    /// Teh description of the contact details.
    description: ?[]const u8,

    /// The name of the contact details.
    name: ?[]const u8,

    pub const json_field_names = .{
        .description = "Description",
        .name = "Name",
    };
};
