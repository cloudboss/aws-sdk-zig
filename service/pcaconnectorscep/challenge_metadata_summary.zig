/// Details about the specified challenge, returned by the
/// [GetChallengeMetadata](https://docs.aws.amazon.com/C4SCEP_API/pca-connector-scep/latest/APIReference/API_GetChallengeMetadata.html) action.
pub const ChallengeMetadataSummary = struct {
    /// The Amazon Resource Name (ARN) of the challenge.
    arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the connector.
    connector_arn: ?[]const u8 = null,

    /// The date and time that the challenge was created.
    created_at: ?i64 = null,

    /// The date and time that the challenge was updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .connector_arn = "ConnectorArn",
        .created_at = "CreatedAt",
        .updated_at = "UpdatedAt",
    };
};
