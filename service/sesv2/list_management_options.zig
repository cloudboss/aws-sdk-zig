/// An object used to specify a list or topic to which an email belongs, which
/// will be
/// used when a contact chooses to unsubscribe.
pub const ListManagementOptions = struct {
    /// The name of the contact list.
    contact_list_name: []const u8,

    /// The name of the topic.
    topic_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .contact_list_name = "ContactListName",
        .topic_name = "TopicName",
    };
};
