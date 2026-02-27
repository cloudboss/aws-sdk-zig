/// The settings that you want to use for the Generative Q&A experience.
pub const AnonymousUserGenerativeQnAEmbeddingConfiguration = struct {
    /// The Quick Sight Q topic ID of the new reader experience topic that you want
    /// the anonymous user to see first. This ID is included in the output URL. When
    /// the URL in response is accessed, Quick Sight renders the Generative Q&A
    /// experience with this new reader experience topic pre selected.
    ///
    /// The Amazon Resource Name (ARN) of this Q new reader experience topic must be
    /// included in the `AuthorizedResourceArns` parameter. Otherwise, the request
    /// fails with an `InvalidParameterValueException` error.
    initial_topic_id: []const u8,

    pub const json_field_names = .{
        .initial_topic_id = "InitialTopicId",
    };
};
