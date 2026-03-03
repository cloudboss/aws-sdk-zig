const TopicPreference = @import("topic_preference.zig").TopicPreference;

/// A contact is the end-user who is receiving the email.
pub const Contact = struct {
    /// The contact's email address.
    email_address: ?[]const u8 = null,

    /// A timestamp noting the last time the contact's information was updated.
    last_updated_timestamp: ?i64 = null,

    /// The default topic preferences applied to the contact.
    topic_default_preferences: ?[]const TopicPreference = null,

    /// The contact's preference for being opted-in to or opted-out of a topic.
    topic_preferences: ?[]const TopicPreference = null,

    /// A boolean value status noting if the contact is unsubscribed from all
    /// contact list
    /// topics.
    unsubscribe_all: bool = false,

    pub const json_field_names = .{
        .email_address = "EmailAddress",
        .last_updated_timestamp = "LastUpdatedTimestamp",
        .topic_default_preferences = "TopicDefaultPreferences",
        .topic_preferences = "TopicPreferences",
        .unsubscribe_all = "UnsubscribeAll",
    };
};
