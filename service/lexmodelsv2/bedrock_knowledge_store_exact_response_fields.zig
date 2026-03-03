/// The exact response fields given by the Bedrock knowledge store.
pub const BedrockKnowledgeStoreExactResponseFields = struct {
    /// The answer field used for an exact response from Bedrock Knowledge Store.
    answer_field: ?[]const u8 = null,

    pub const json_field_names = .{
        .answer_field = "answerField",
    };
};
