/// Provides details about an Database Migration Service (DMS) endpoint. An
/// endpoint provides connection, data
/// store type, and location information about your data store.
pub const AwsDmsEndpointDetails = struct {
    /// The Amazon Resource Name (ARN) for the SSL certificate that encrypts
    /// connections between the DMS endpoint and the
    /// replication instance.
    certificate_arn: ?[]const u8 = null,

    /// The name of the endpoint database.
    database_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the endpoint.
    endpoint_arn: ?[]const u8 = null,

    /// The database endpoint identifier.
    endpoint_identifier: ?[]const u8 = null,

    /// The type of endpoint. Valid values are source and target.
    endpoint_type: ?[]const u8 = null,

    /// The type of engine for the endpoint, depending on the `EndpointType` value.
    engine_name: ?[]const u8 = null,

    /// A value that can be used for cross-account validation.
    external_id: ?[]const u8 = null,

    /// Additional attributes associated with the connection.
    extra_connection_attributes: ?[]const u8 = null,

    /// An DMS key identifier that is used to encrypt the connection parameters for
    /// the endpoint.
    /// If you don't specify a value for the `KmsKeyId` parameter, then DMS uses
    /// your default
    /// encryption key. KMS creates the default encryption key for your Amazon Web
    /// Services account. Your
    /// Amazon Web Services account has a different default encryption key for each
    /// Amazon Web Services Region.
    kms_key_id: ?[]const u8 = null,

    /// The port used to access the endpoint.
    port: ?i32 = null,

    /// The name of the server where the endpoint database resides.
    server_name: ?[]const u8 = null,

    /// The SSL mode used to connect to the endpoint. The default is none.
    ssl_mode: ?[]const u8 = null,

    /// The user name to be used to log in to the endpoint database.
    username: ?[]const u8 = null,

    pub const json_field_names = .{
        .certificate_arn = "CertificateArn",
        .database_name = "DatabaseName",
        .endpoint_arn = "EndpointArn",
        .endpoint_identifier = "EndpointIdentifier",
        .endpoint_type = "EndpointType",
        .engine_name = "EngineName",
        .external_id = "ExternalId",
        .extra_connection_attributes = "ExtraConnectionAttributes",
        .kms_key_id = "KmsKeyId",
        .port = "Port",
        .server_name = "ServerName",
        .ssl_mode = "SslMode",
        .username = "Username",
    };
};
