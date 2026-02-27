/// Contains configuration about the session with the knowledge base.
///
/// This data type is used in the following API operations:
///
/// * [RetrieveAndGenerate
///   request](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent-runtime_RetrieveAndGenerate.html#API_agent-runtime_RetrieveAndGenerate_RequestSyntax) – in the `sessionConfiguration` field
pub const RetrieveAndGenerateSessionConfiguration = struct {
    /// The ARN of the KMS key encrypting the session.
    kms_key_arn: []const u8,

    pub const json_field_names = .{
        .kms_key_arn = "kmsKeyArn",
    };
};
