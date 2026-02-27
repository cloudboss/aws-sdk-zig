/// A list that contains contacts that have subscribed to a particular topic or
/// topics.
pub const ContactList = struct {
    /// The name of the contact list.
    contact_list_name: ?[]const u8,

    /// A timestamp noting the last time the contact list was updated.
    last_updated_timestamp: ?i64,

    pub const json_field_names = .{
        .contact_list_name = "ContactListName",
        .last_updated_timestamp = "LastUpdatedTimestamp",
    };
};
