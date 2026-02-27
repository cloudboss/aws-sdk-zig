/// A sample utterance that invokes an intent or respond to a slot
/// elicitation prompt.
pub const SampleUtterance = struct {
    /// The sample utterance that Amazon Lex uses to build its machine-learning
    /// model to recognize intents.
    utterance: []const u8,

    pub const json_field_names = .{
        .utterance = "utterance",
    };
};
