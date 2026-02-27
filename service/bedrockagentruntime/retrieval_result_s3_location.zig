/// The S3 data source location.
///
/// This data type is used in the following API operations:
///
/// * [Retrieve
///   response](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent-runtime_Retrieve.html#API_agent-runtime_Retrieve_ResponseSyntax) – in the `s3Location` field
/// * [RetrieveAndGenerate
///   response](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent-runtime_RetrieveAndGenerate.html#API_agent-runtime_RetrieveAndGenerate_ResponseSyntax) – in the `s3Location` field
/// * [InvokeAgent
///   response](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent-runtime_InvokeAgent.html#API_agent-runtime_InvokeAgent_ResponseSyntax) – in the `s3Location` field
pub const RetrievalResultS3Location = struct {
    /// The S3 URI for the data source location.
    uri: ?[]const u8,

    pub const json_field_names = .{
        .uri = "uri",
    };
};
