/// Contains configurations for a Lex node in the flow. You specify a Amazon Lex
/// bot to invoke. This node takes an utterance as the input and returns as the
/// output the intent identified by the Amazon Lex bot. For more information,
/// see [Node types in a
/// flow](https://docs.aws.amazon.com/bedrock/latest/userguide/flows-nodes.html)
/// in the Amazon Bedrock User Guide.
pub const LexFlowNodeConfiguration = struct {
    /// The Amazon Resource Name (ARN) of the Amazon Lex bot alias to invoke.
    bot_alias_arn: []const u8 = "",

    /// The Region to invoke the Amazon Lex bot in.
    locale_id: []const u8 = "",

    pub const json_field_names = .{
        .bot_alias_arn = "botAliasArn",
        .locale_id = "localeId",
    };
};
