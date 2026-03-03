const As2ConnectorConfig = @import("as_2_connector_config.zig").As2ConnectorConfig;
const DescribedConnectorEgressConfig = @import("described_connector_egress_config.zig").DescribedConnectorEgressConfig;
const ConnectorEgressType = @import("connector_egress_type.zig").ConnectorEgressType;
const SftpConnectorConfig = @import("sftp_connector_config.zig").SftpConnectorConfig;
const ConnectorStatus = @import("connector_status.zig").ConnectorStatus;
const Tag = @import("tag.zig").Tag;

/// Describes the parameters for the connector, as identified by the
/// `ConnectorId`.
pub const DescribedConnector = struct {
    /// Connectors are used to send files using either the AS2 or SFTP protocol. For
    /// the access role, provide the Amazon Resource Name (ARN) of the Identity and
    /// Access Management role to use.
    ///
    /// **For AS2 connectors**
    ///
    /// With AS2, you can send files by calling `StartFileTransfer` and specifying
    /// the file paths in the request parameter, `SendFilePaths`. We use the file’s
    /// parent directory (for example, for `--send-file-paths /bucket/dir/file.txt`,
    /// parent directory is `/bucket/dir/`) to temporarily store a processed AS2
    /// message file, store the MDN when we receive them from the partner, and write
    /// a final JSON file containing relevant metadata of the transmission. So, the
    /// `AccessRole` needs to provide read and write access to the parent directory
    /// of the file location used in the `StartFileTransfer` request. Additionally,
    /// you need to provide read and write access to the parent directory of the
    /// files that you intend to send with `StartFileTransfer`.
    ///
    /// If you are using Basic authentication for your AS2 connector, the access
    /// role requires the `secretsmanager:GetSecretValue` permission for the secret.
    /// If the secret is encrypted using a customer-managed key instead of the
    /// Amazon Web Services managed key in Secrets Manager, then the role also needs
    /// the `kms:Decrypt` permission for that key.
    ///
    /// **For SFTP connectors**
    ///
    /// Make sure that the access role provides read and write access to the parent
    /// directory of the file location that's used in the `StartFileTransfer`
    /// request. Additionally, make sure that the role provides
    /// `secretsmanager:GetSecretValue` permission to Secrets Manager.
    access_role: ?[]const u8 = null,

    /// The unique Amazon Resource Name (ARN) for the connector.
    arn: []const u8,

    /// A structure that contains the parameters for an AS2 connector object.
    as_2_config: ?As2ConnectorConfig = null,

    /// The unique identifier for the connector.
    connector_id: ?[]const u8 = null,

    /// Current egress configuration of the connector, showing how traffic is routed
    /// to the SFTP server. Contains VPC Lattice settings when using VPC_LATTICE
    /// egress type.
    ///
    /// When using the VPC_LATTICE egress type, Transfer Family uses a managed
    /// Service Network to simplify the resource sharing process.
    egress_config: ?DescribedConnectorEgressConfig = null,

    /// Type of egress configuration for the connector. SERVICE_MANAGED uses
    /// Transfer Family managed NAT gateways, while VPC_LATTICE routes traffic
    /// through customer VPCs using VPC Lattice.
    egress_type: ConnectorEgressType = "SERVICE_MANAGED",

    /// Error message providing details when the connector is in ERRORED status.
    /// Contains information to help troubleshoot connector creation or operation
    /// failures.
    error_message: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the Identity and Access Management (IAM)
    /// role that allows a connector to turn on CloudWatch logging for Amazon S3
    /// events. When set, you can view connector activity in your CloudWatch logs.
    logging_role: ?[]const u8 = null,

    /// The text name of the security policy for the specified connector.
    security_policy_name: ?[]const u8 = null,

    /// The list of egress IP addresses of this connector. These IP addresses are
    /// assigned automatically when you create the connector.
    service_managed_egress_ip_addresses: ?[]const []const u8 = null,

    /// A structure that contains the parameters for an SFTP connector object.
    sftp_config: ?SftpConnectorConfig = null,

    /// Current status of the connector. PENDING indicates creation/update in
    /// progress, ACTIVE means ready for operations, and ERRORED indicates a failure
    /// requiring attention.
    status: ConnectorStatus = "ACTIVE",

    /// Key-value pairs that can be used to group and search for connectors.
    tags: ?[]const Tag = null,

    /// The URL of the partner's AS2 or SFTP endpoint.
    ///
    /// When creating AS2 connectors or service-managed SFTP connectors (connectors
    /// without egress configuration), you must provide a URL to specify the remote
    /// server endpoint. For VPC Lattice type connectors, the URL must be null.
    url: ?[]const u8 = null,

    pub const json_field_names = .{
        .access_role = "AccessRole",
        .arn = "Arn",
        .as_2_config = "As2Config",
        .connector_id = "ConnectorId",
        .egress_config = "EgressConfig",
        .egress_type = "EgressType",
        .error_message = "ErrorMessage",
        .logging_role = "LoggingRole",
        .security_policy_name = "SecurityPolicyName",
        .service_managed_egress_ip_addresses = "ServiceManagedEgressIpAddresses",
        .sftp_config = "SftpConfig",
        .status = "Status",
        .tags = "Tags",
        .url = "Url",
    };
};
