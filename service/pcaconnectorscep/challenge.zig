/// For Connector for SCEP for general-purpose. An object containing information
/// about the specified connector's SCEP challenge passwords.
pub const Challenge = struct {
    /// The Amazon Resource Name (ARN) of the challenge.
    arn: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the connector.
    connector_arn: ?[]const u8,

    /// The date and time that the challenge was created.
    created_at: ?i64,

    /// The SCEP challenge password, in UUID format.
    password: ?[]const u8,

    /// The date and time that the challenge was updated.
    updated_at: ?i64,

    pub const json_field_names = .{
        .arn = "Arn",
        .connector_arn = "ConnectorArn",
        .created_at = "CreatedAt",
        .password = "Password",
        .updated_at = "UpdatedAt",
    };
};
