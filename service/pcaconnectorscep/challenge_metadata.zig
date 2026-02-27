/// Contains details about the connector's challenge.
pub const ChallengeMetadata = struct {
    /// The Amazon Resource Name (ARN) of the challenge.
    arn: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the connector.
    connector_arn: ?[]const u8,

    /// The date and time that the connector was created.
    created_at: ?i64,

    /// The date and time that the connector was updated.
    updated_at: ?i64,

    pub const json_field_names = .{
        .arn = "Arn",
        .connector_arn = "ConnectorArn",
        .created_at = "CreatedAt",
        .updated_at = "UpdatedAt",
    };
};
