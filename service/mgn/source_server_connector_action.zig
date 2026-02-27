/// Source Server connector action.
pub const SourceServerConnectorAction = struct {
    /// Source Server connector action connector arn.
    connector_arn: ?[]const u8,

    /// Source Server connector action credentials secret arn.
    credentials_secret_arn: ?[]const u8,

    pub const json_field_names = .{
        .connector_arn = "connectorArn",
        .credentials_secret_arn = "credentialsSecretArn",
    };
};
