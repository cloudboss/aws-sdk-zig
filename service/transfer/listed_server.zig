const Domain = @import("domain.zig").Domain;
const EndpointType = @import("endpoint_type.zig").EndpointType;
const IdentityProviderType = @import("identity_provider_type.zig").IdentityProviderType;
const State = @import("state.zig").State;

/// Returns properties of a file transfer protocol-enabled server that was
/// specified.
pub const ListedServer = struct {
    /// Specifies the unique Amazon Resource Name (ARN) for a server to be listed.
    arn: []const u8,

    /// Specifies the domain of the storage system that is used for file transfers.
    /// There are two domains available: Amazon Simple Storage Service (Amazon S3)
    /// and Amazon Elastic File System (Amazon EFS). The default value is S3.
    domain: ?Domain,

    /// Specifies the type of VPC endpoint that your server is connected to. If your
    /// server is connected to a VPC endpoint, your server isn't accessible over the
    /// public internet.
    endpoint_type: ?EndpointType,

    /// The mode of authentication for a server. The default value is
    /// `SERVICE_MANAGED`, which allows you to store and access user credentials
    /// within the Transfer Family service.
    ///
    /// Use `AWS_DIRECTORY_SERVICE` to provide access to Active Directory groups in
    /// Directory Service for Microsoft Active Directory or Microsoft Active
    /// Directory in your on-premises environment or in Amazon Web Services using AD
    /// Connector. This option also requires you to provide a Directory ID by using
    /// the `IdentityProviderDetails` parameter.
    ///
    /// Use the `API_GATEWAY` value to integrate with an identity provider of your
    /// choosing. The `API_GATEWAY` setting requires you to provide an Amazon API
    /// Gateway endpoint URL to call for authentication by using the
    /// `IdentityProviderDetails` parameter.
    ///
    /// Use the `AWS_LAMBDA` value to directly use an Lambda function as your
    /// identity provider. If you choose this value, you must specify the ARN for
    /// the Lambda function in the `Function` parameter for the
    /// `IdentityProviderDetails` data type.
    identity_provider_type: ?IdentityProviderType,

    /// The Amazon Resource Name (ARN) of the Identity and Access Management (IAM)
    /// role that allows a server to turn on Amazon CloudWatch logging for Amazon S3
    /// or Amazon EFS events. When set, you can view user activity in your
    /// CloudWatch logs.
    logging_role: ?[]const u8,

    /// Specifies the unique system assigned identifier for the servers that were
    /// listed.
    server_id: ?[]const u8,

    /// The condition of the server that was described. A value of `ONLINE`
    /// indicates that the server can accept jobs and transfer files. A `State`
    /// value of `OFFLINE` means that the server cannot perform file transfer
    /// operations.
    ///
    /// The states of `STARTING` and `STOPPING` indicate that the server is in an
    /// intermediate state, either not fully able to respond, or not fully offline.
    /// The values of `START_FAILED` or `STOP_FAILED` can indicate an error
    /// condition.
    state: ?State,

    /// Specifies the number of users that are assigned to a server you specified
    /// with the `ServerId`.
    user_count: ?i32,

    pub const json_field_names = .{
        .arn = "Arn",
        .domain = "Domain",
        .endpoint_type = "EndpointType",
        .identity_provider_type = "IdentityProviderType",
        .logging_role = "LoggingRole",
        .server_id = "ServerId",
        .state = "State",
        .user_count = "UserCount",
    };
};
