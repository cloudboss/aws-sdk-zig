const Intent = @import("intent.zig").Intent;
const InterpretationSource = @import("interpretation_source.zig").InterpretationSource;
const ConfidenceScore = @import("confidence_score.zig").ConfidenceScore;
const SentimentResponse = @import("sentiment_response.zig").SentimentResponse;

/// An object containing information about an intent that Amazon Lex V2
/// determined might satisfy the user's utterance.
/// The intents are ordered by the confidence score.
pub const Interpretation = struct {
    /// A list of intents that might satisfy the user's utterance. The
    /// intents are ordered by the confidence score.
    intent: ?Intent = null,

    /// Specifies the service that interpreted the input.
    interpretation_source: ?InterpretationSource = null,

    /// Determines the threshold where Amazon Lex V2 will insert the
    /// `AMAZON.FallbackIntent`,
    /// `AMAZON.KendraSearchIntent`, or both when returning
    /// alternative intents in a response. `AMAZON.FallbackIntent`
    /// and `AMAZON.KendraSearchIntent` are only inserted if they
    /// are configured for the bot.
    nlu_confidence: ?ConfidenceScore = null,

    /// The sentiment expressed in an utterance.
    ///
    /// When the bot is configured to send utterances to Amazon Comprehend
    /// for sentiment analysis, this field contains the result of the
    /// analysis.
    sentiment_response: ?SentimentResponse = null,

    pub const json_field_names = .{
        .intent = "intent",
        .interpretation_source = "interpretationSource",
        .nlu_confidence = "nluConfidence",
        .sentiment_response = "sentimentResponse",
    };
};
