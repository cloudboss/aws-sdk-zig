/// An object that provides information about the configuration of a Generative
/// Q&A experience.
pub const RegisteredUserGenerativeQnAEmbeddingConfiguration = struct {
    /// The ID of the new Q reader experience topic that you want to make the
    /// starting topic
    /// in the Generative Q&A experience. You can find a topic ID by navigating to
    /// the Topics pane in the Quick application and opening a topic. The ID is in
    /// the URL for the topic that
    /// you open.
    ///
    /// If you don't specify an initial topic or you specify a legacy topic, a list
    /// of all
    /// shared new reader experience topics is shown in the Generative Q&A
    /// experience for
    /// your readers. When you select an initial new reader experience topic, you
    /// can specify
    /// whether or not readers are allowed to select other new reader experience
    /// topics from the
    /// available ones in the list.
    initial_topic_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .initial_topic_id = "InitialTopicId",
    };
};
