/// Information about the Q search bar embedding experience.
pub const RegisteredUserQSearchBarEmbeddingConfiguration = struct {
    /// The ID of the legacy Q topic that you want to use as the starting topic in
    /// the Q
    /// search bar. To locate the topic ID of the topic that you want to use, open
    /// the [Quick Sight console](https://quicksight.aws.amazon.com/), navigate to
    /// the
    /// **Topics** pane, and choose thre topic that you want to
    /// use. The `TopicID` is located in the URL of the topic that opens. When you
    /// select an initial topic, you can specify whether or not readers are allowed
    /// to select
    /// other topics from the list of available topics.
    ///
    /// If you don't specify an initial topic or if you specify a new reader
    /// experience topic,
    /// a list of all shared legacy topics is shown in the Q bar.
    initial_topic_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .initial_topic_id = "InitialTopicId",
    };
};
