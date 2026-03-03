/// Used for filtering by a specific topic preference.
pub const TopicFilter = struct {
    /// The name of a topic on which you wish to apply the filter.
    topic_name: ?[]const u8 = null,

    /// Notes that the default subscription status should be applied to a contact
    /// because the
    /// contact has not noted their preference for subscribing to a topic.
    use_default_if_preference_unavailable: bool = false,

    pub const json_field_names = .{
        .topic_name = "TopicName",
        .use_default_if_preference_unavailable = "UseDefaultIfPreferenceUnavailable",
    };
};
