/// The settings that you want to use with the Q search bar.
pub const AnonymousUserQSearchBarEmbeddingConfiguration = struct {
    /// The Quick Sight Q topic ID of the legacy topic that you want the anonymous
    /// user to see first. This ID is included in the output URL. When the URL in
    /// response is accessed, Quick Sight renders the Q search bar with this legacy
    /// topic pre-selected.
    ///
    /// The Amazon Resource Name (ARN) of this Q legacy topic must be included in
    /// the `AuthorizedResourceArns` parameter. Otherwise, the request fails with an
    /// `InvalidParameterValueException` error.
    initial_topic_id: []const u8,

    pub const json_field_names = .{
        .initial_topic_id = "InitialTopicId",
    };
};
