const ConnectionAuthorizationType = @import("connection_authorization_type.zig").ConnectionAuthorizationType;
const UpdateConnectionAuthRequestParameters = @import("update_connection_auth_request_parameters.zig").UpdateConnectionAuthRequestParameters;
const ConnectivityResourceParameters = @import("connectivity_resource_parameters.zig").ConnectivityResourceParameters;

pub const UpdateConnectionRequest = struct {
    /// The type of authorization to use for the connection.
    authorization_type: ?ConnectionAuthorizationType,

    /// The authorization parameters to use for the connection.
    auth_parameters: ?UpdateConnectionAuthRequestParameters,

    /// A description for the connection.
    description: ?[]const u8,

    /// For connections to private APIs, the parameters to use for invoking the API.
    ///
    /// For more information, see [Connecting to private
    /// APIs](https://docs.aws.amazon.com/eventbridge/latest/userguide/connection-private.html) in the *
    /// Amazon EventBridge User Guide*
    /// .
    invocation_connectivity_parameters: ?ConnectivityResourceParameters,

    /// The identifier of the KMS
    /// customer managed key for EventBridge to use, if you choose to use a customer
    /// managed key to encrypt this connection. The identifier can be the key
    /// Amazon Resource Name (ARN), KeyId, key alias, or key alias ARN.
    ///
    /// If you do not specify a customer managed key identifier, EventBridge uses an
    /// Amazon Web Services owned key to encrypt the connection.
    ///
    /// For more information, see [Identify and view
    /// keys](https://docs.aws.amazon.com/kms/latest/developerguide/viewing-keys.html) in the *Key Management Service
    /// Developer Guide*.
    kms_key_identifier: ?[]const u8,

    /// The name of the connection to update.
    name: []const u8,

    pub const json_field_names = .{
        .authorization_type = "AuthorizationType",
        .auth_parameters = "AuthParameters",
        .description = "Description",
        .invocation_connectivity_parameters = "InvocationConnectivityParameters",
        .kms_key_identifier = "KmsKeyIdentifier",
        .name = "Name",
    };
};
