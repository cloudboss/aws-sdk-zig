const aws = @import("aws");

const IntentConfidence = @import("intent_confidence.zig").IntentConfidence;

/// An intent that Amazon Lex suggests satisfies the user's intent. Includes
/// the name of the intent, the confidence that Amazon Lex has that the user's
/// intent is satisfied, and the slots defined for the intent.
pub const PredictedIntent = struct {
    /// The name of the intent that Amazon Lex suggests satisfies the user's
    /// intent.
    intent_name: ?[]const u8 = null,

    /// Indicates how confident Amazon Lex is that an intent satisfies the user's
    /// intent.
    nlu_intent_confidence: ?IntentConfidence = null,

    /// The slot and slot values associated with the predicted intent.
    slots: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .intent_name = "intentName",
        .nlu_intent_confidence = "nluIntentConfidence",
        .slots = "slots",
    };
};
