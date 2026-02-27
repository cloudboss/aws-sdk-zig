/// The proposed access control configuration for a DynamoDB stream. You can
/// propose a configuration for a new DynamoDB stream or an existing DynamoDB
/// stream that you own by specifying the policy for the DynamoDB stream. For
/// more information, see
/// [PutResourcePolicy](https://docs.aws.amazon.com/amazondynamodb/latest/APIReference/API_PutResourcePolicy.html).
///
/// * If the configuration is for an existing DynamoDB stream and you do not
///   specify the DynamoDB policy, then the access preview uses the existing
///   DynamoDB policy for the stream.
/// * If the access preview is for a new resource and you do not specify the
///   policy, then the access preview assumes a DynamoDB stream without a
///   policy.
/// * To propose deletion of an existing DynamoDB stream policy, you can specify
///   an empty string for the DynamoDB policy.
pub const DynamodbStreamConfiguration = struct {
    /// The proposed resource policy defining who can access or manage the DynamoDB
    /// stream.
    stream_policy: ?[]const u8,

    pub const json_field_names = .{
        .stream_policy = "streamPolicy",
    };
};
