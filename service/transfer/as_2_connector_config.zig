const As2AsyncMdnConnectorConfig = @import("as_2_async_mdn_connector_config.zig").As2AsyncMdnConnectorConfig;
const CompressionEnum = @import("compression_enum.zig").CompressionEnum;
const EncryptionAlg = @import("encryption_alg.zig").EncryptionAlg;
const MdnResponse = @import("mdn_response.zig").MdnResponse;
const MdnSigningAlg = @import("mdn_signing_alg.zig").MdnSigningAlg;
const PreserveContentType = @import("preserve_content_type.zig").PreserveContentType;
const SigningAlg = @import("signing_alg.zig").SigningAlg;

/// Contains the details for an AS2 connector object. The connector object is
/// used for AS2 outbound processes, to connect the Transfer Family customer
/// with the trading partner.
pub const As2ConnectorConfig = struct {
    /// Configuration settings for asynchronous Message Disposition Notification
    /// (MDN) responses. This allows you to configure where asynchronous MDN
    /// responses should be sent and which servers should handle them.
    async_mdn_config: ?As2AsyncMdnConnectorConfig = null,

    /// Provides Basic authentication support to the AS2 Connectors API. To use
    /// Basic authentication, you must provide the name or Amazon Resource Name
    /// (ARN) of a secret in Secrets Manager.
    ///
    /// The default value for this parameter is `null`, which indicates that Basic
    /// authentication is not enabled for the connector.
    ///
    /// If the connector should use Basic authentication, the secret needs to be in
    /// the following format:
    ///
    /// `{ "Username": "user-name", "Password": "user-password" }`
    ///
    /// Replace `user-name` and `user-password` with the credentials for the actual
    /// user that is being authenticated.
    ///
    /// Note the following:
    ///
    /// * You are storing these credentials in Secrets Manager, *not passing them
    ///   directly* into this API.
    /// * If you are using the API, SDKs, or CloudFormation to configure your
    ///   connector, then you must create the secret before you can enable Basic
    ///   authentication. However, if you are using the Amazon Web Services
    ///   management console, you can have the system create the secret for you.
    ///
    /// If you have previously enabled Basic authentication for a connector, you can
    /// disable it by using the `UpdateConnector` API call. For example, if you are
    /// using the CLI, you can run the following command to remove Basic
    /// authentication:
    ///
    /// `update-connector --connector-id my-connector-id --as2-config
    /// 'BasicAuthSecretId=""'`
    basic_auth_secret_id: ?[]const u8 = null,

    /// Specifies whether the AS2 file is compressed.
    compression: ?CompressionEnum = null,

    /// The algorithm that is used to encrypt the file.
    ///
    /// Note the following:
    ///
    /// * Do not use the `DES_EDE3_CBC` algorithm unless you must support a legacy
    ///   client that requires it, as it is a weak encryption algorithm.
    /// * You can only specify `NONE` if the URL for your connector uses HTTPS.
    ///   Using HTTPS ensures that no traffic is sent in clear text.
    encryption_algorithm: ?EncryptionAlg = null,

    /// A unique identifier for the AS2 local profile.
    local_profile_id: ?[]const u8 = null,

    /// Used for outbound requests (from an Transfer Family connector to a partner
    /// AS2 server) to determine whether the partner response for transfers is
    /// synchronous or asynchronous. Specify either of the following values:
    ///
    /// * `ASYNC`: The system expects an asynchronous MDN response, confirming that
    ///   the file was transferred successfully (or not).
    /// * `SYNC`: The system expects a synchronous MDN response, confirming that the
    ///   file was transferred successfully (or not).
    /// * `NONE`: Specifies that no MDN response is required.
    mdn_response: ?MdnResponse = null,

    /// The signing algorithm for the MDN response.
    ///
    /// If set to DEFAULT (or not set at all), the value for `SigningAlgorithm` is
    /// used.
    mdn_signing_algorithm: ?MdnSigningAlg = null,

    /// Used as the `Subject` HTTP header attribute in AS2 messages that are being
    /// sent with the connector.
    message_subject: ?[]const u8 = null,

    /// A unique identifier for the partner profile for the connector.
    partner_profile_id: ?[]const u8 = null,

    /// Allows you to use the Amazon S3 `Content-Type` that is associated with
    /// objects in S3 instead of having the content type mapped based on the file
    /// extension. This parameter is enabled by default when you create an AS2
    /// connector from the console, but disabled by default when you create an AS2
    /// connector by calling the API directly.
    preserve_content_type: ?PreserveContentType = null,

    /// The algorithm that is used to sign the AS2 messages sent with the connector.
    signing_algorithm: ?SigningAlg = null,

    pub const json_field_names = .{
        .async_mdn_config = "AsyncMdnConfig",
        .basic_auth_secret_id = "BasicAuthSecretId",
        .compression = "Compression",
        .encryption_algorithm = "EncryptionAlgorithm",
        .local_profile_id = "LocalProfileId",
        .mdn_response = "MdnResponse",
        .mdn_signing_algorithm = "MdnSigningAlgorithm",
        .message_subject = "MessageSubject",
        .partner_profile_id = "PartnerProfileId",
        .preserve_content_type = "PreserveContentType",
        .signing_algorithm = "SigningAlgorithm",
    };
};
