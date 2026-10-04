/// Details about a proactive recommendation, including the token used to
/// retrieve its chunked response with `GetNextMessage`.
pub const ProactiveRecommendationDataDetails = struct {
    /// The token used to retrieve the next message in the proactive recommendation.
    /// Pass this token in a `GetNextMessage` request to continue receiving the
    /// chunked proactive response. Each response returns the next token to use
    /// until the chunked response is complete.
    next_message_token: []const u8,

    pub const json_field_names = .{
        .next_message_token = "nextMessageToken",
    };
};
