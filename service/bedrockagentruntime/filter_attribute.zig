/// Specifies the name that the metadata attribute must match and the value to
/// which to compare the value of the metadata attribute. For more information,
/// see [Query
/// configurations](https://docs.aws.amazon.com/bedrock/latest/userguide/kb-test-config.html).
///
/// This data type is used in the following API operations:
///
/// * [RetrieveAndGenerate
///   request](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent-runtime_RetrieveAndGenerate.html#API_agent-runtime_RetrieveAndGenerate_RequestSyntax)
pub const FilterAttribute = struct {
    /// The name that the metadata attribute must match.
    key: []const u8,

    /// The value to whcih to compare the value of the metadata attribute.
    value: []const u8,

    pub const json_field_names = .{
        .key = "key",
        .value = "value",
    };
};
