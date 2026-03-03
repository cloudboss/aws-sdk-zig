const Domain = @import("domain.zig").Domain;
const EndpointDetails = @import("endpoint_details.zig").EndpointDetails;
const EndpointType = @import("endpoint_type.zig").EndpointType;
const IdentityProviderDetails = @import("identity_provider_details.zig").IdentityProviderDetails;
const IdentityProviderType = @import("identity_provider_type.zig").IdentityProviderType;
const IpAddressType = @import("ip_address_type.zig").IpAddressType;
const ProtocolDetails = @import("protocol_details.zig").ProtocolDetails;
const Protocol = @import("protocol.zig").Protocol;
const S3StorageOptions = @import("s3_storage_options.zig").S3StorageOptions;
const State = @import("state.zig").State;
const Tag = @import("tag.zig").Tag;
const WorkflowDetails = @import("workflow_details.zig").WorkflowDetails;

/// Describes the properties of a file transfer protocol-enabled server that was
/// specified.
pub const DescribedServer = struct {
    /// Specifies the unique Amazon Resource Name (ARN) of the server.
    arn: []const u8,

    /// The list of egress IP addresses of this server. These IP addresses are only
    /// relevant for servers that use the AS2 protocol. They are used for sending
    /// asynchronous MDNs.
    ///
    /// These IP addresses are assigned automatically when you create an AS2 server.
    /// Additionally, if you update an existing server and add the AS2 protocol,
    /// static IP addresses are assigned as well.
    as_2_service_managed_egress_ip_addresses: ?[]const []const u8 = null,

    /// Specifies the ARN of the Amazon Web ServicesCertificate Manager (ACM)
    /// certificate. Required when `Protocols` is set to `FTPS`.
    certificate: ?[]const u8 = null,

    /// Specifies the domain of the storage system that is used for file transfers.
    /// There are two domains available: Amazon Simple Storage Service (Amazon S3)
    /// and Amazon Elastic File System (Amazon EFS). The default value is S3.
    domain: ?Domain = null,

    /// The virtual private cloud (VPC) endpoint settings that are configured for
    /// your server. When you host your endpoint within your VPC, you can make your
    /// endpoint accessible only to resources within your VPC, or you can attach
    /// Elastic IP addresses and make your endpoint accessible to clients over the
    /// internet. Your VPC's default security groups are automatically assigned to
    /// your endpoint.
    endpoint_details: ?EndpointDetails = null,

    /// Defines the type of endpoint that your server is connected to. If your
    /// server is connected to a VPC endpoint, your server isn't accessible over the
    /// public internet.
    endpoint_type: ?EndpointType = null,

    /// Specifies the Base64-encoded SHA256 fingerprint of the server's host key.
    /// This value is equivalent to the output of the `ssh-keygen -l -f
    /// my-new-server-key` command.
    host_key_fingerprint: ?[]const u8 = null,

    /// Specifies information to call a customer-supplied authentication API. This
    /// field is not populated when the `IdentityProviderType` of a server is
    /// `AWS_DIRECTORY_SERVICE` or `SERVICE_MANAGED`.
    identity_provider_details: ?IdentityProviderDetails = null,

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
    identity_provider_type: ?IdentityProviderType = null,

    /// Specifies whether to use IPv4 only, or to use dual-stack (IPv4 and IPv6) for
    /// your Transfer Family endpoint. The default value is `IPV4`.
    ///
    /// The `IpAddressType` parameter has the following limitations:
    ///
    /// * It cannot be changed while the server is online. You must stop the server
    ///   before modifying this parameter.
    /// * It cannot be updated to `DUALSTACK` if the server has
    ///   `AddressAllocationIds` specified.
    ///
    /// When using `DUALSTACK` as the `IpAddressType`, you cannot set the
    /// `AddressAllocationIds` parameter for the
    /// [EndpointDetails](https://docs.aws.amazon.com/transfer/latest/APIReference/API_EndpointDetails.html) for the server.
    ip_address_type: ?IpAddressType = null,

    /// The Amazon Resource Name (ARN) of the Identity and Access Management (IAM)
    /// role that allows a server to turn on Amazon CloudWatch logging for Amazon S3
    /// or Amazon EFS events. When set, you can view user activity in your
    /// CloudWatch logs.
    logging_role: ?[]const u8 = null,

    /// Specifies a string to display when users connect to a server. This string is
    /// displayed after the user authenticates.
    ///
    /// The SFTP protocol does not support post-authentication display banners.
    post_authentication_login_banner: ?[]const u8 = null,

    /// Specifies a string to display when users connect to a server. This string is
    /// displayed before the user authenticates. For example, the following banner
    /// displays details about using the system:
    ///
    /// `This system is for the use of authorized users only. Individuals using this
    /// computer system without authority, or in excess of their authority, are
    /// subject to having all of their activities on this system monitored and
    /// recorded by system personnel.`
    pre_authentication_login_banner: ?[]const u8 = null,

    /// The protocol settings that are configured for your server.
    ///
    /// Avoid placing Network Load Balancers (NLBs) or NAT gateways in front of
    /// Transfer Family servers, as this increases costs and can cause performance
    /// issues, including reduced connection limits for FTPS. For more details, see
    /// [ Avoid placing NLBs and NATs in front of Transfer
    /// Family](https://docs.aws.amazon.com/transfer/latest/userguide/infrastructure-security.html#nlb-considerations).
    ///
    /// * To indicate passive mode (for FTP and FTPS protocols), use the `PassiveIp`
    ///   parameter. Enter a single dotted-quad IPv4 address, such as the external
    ///   IP address of a firewall, router, or load balancer.
    /// * To ignore the error that is generated when the client attempts to use the
    ///   `SETSTAT` command on a file that you are uploading to an Amazon S3 bucket,
    ///   use the `SetStatOption` parameter. To have the Transfer Family server
    ///   ignore the `SETSTAT` command and upload files without needing to make any
    ///   changes to your SFTP client, set the value to `ENABLE_NO_OP`. If you set
    ///   the `SetStatOption` parameter to `ENABLE_NO_OP`, Transfer Family generates
    ///   a log entry to Amazon CloudWatch Logs, so that you can determine when the
    ///   client is making a `SETSTAT` call.
    /// * To determine whether your Transfer Family server resumes recent,
    ///   negotiated sessions through a unique session ID, use the
    ///   `TlsSessionResumptionMode` parameter.
    /// * `As2Transports` indicates the transport method for the AS2 messages.
    ///   Currently, only HTTP is supported.
    protocol_details: ?ProtocolDetails = null,

    /// Specifies the file transfer protocol or protocols over which your file
    /// transfer protocol client can connect to your server's endpoint. The
    /// available protocols are:
    ///
    /// * `SFTP` (Secure Shell (SSH) File Transfer Protocol): File transfer over SSH
    /// * `FTPS` (File Transfer Protocol Secure): File transfer with TLS encryption
    /// * `FTP` (File Transfer Protocol): Unencrypted file transfer
    /// * `AS2` (Applicability Statement 2): used for transporting structured
    ///   business-to-business data
    ///
    /// * If you select `FTPS`, you must choose a certificate stored in Certificate
    ///   Manager (ACM) which is used to identify your server when clients connect
    ///   to it over FTPS.
    /// * If `Protocol` includes either `FTP` or `FTPS`, then the `EndpointType`
    ///   must be `VPC` and the `IdentityProviderType` must be either
    ///   `AWS_DIRECTORY_SERVICE`, `AWS_LAMBDA`, or `API_GATEWAY`.
    /// * If `Protocol` includes `FTP`, then `AddressAllocationIds` cannot be
    ///   associated.
    /// * If `Protocol` is set only to `SFTP`, the `EndpointType` can be set to
    ///   `PUBLIC` and the `IdentityProviderType` can be set any of the supported
    ///   identity types: `SERVICE_MANAGED`, `AWS_DIRECTORY_SERVICE`, `AWS_LAMBDA`,
    ///   or `API_GATEWAY`.
    /// * If `Protocol` includes `AS2`, then the `EndpointType` must be `VPC`, and
    ///   domain must be Amazon S3.
    protocols: ?[]const Protocol = null,

    /// Specifies whether or not performance for your Amazon S3 directories is
    /// optimized.
    ///
    /// * If using the console, this is enabled by default.
    /// * If using the API or CLI, this is disabled by default.
    ///
    /// By default, home directory mappings have a `TYPE` of `DIRECTORY`. If you
    /// enable this option, you would then need to explicitly set the
    /// `HomeDirectoryMapEntry` `Type` to `FILE` if you want a mapping to have a
    /// file target.
    s3_storage_options: ?S3StorageOptions = null,

    /// Specifies the name of the security policy for the server.
    security_policy_name: ?[]const u8 = null,

    /// Specifies the unique system-assigned identifier for a server that you
    /// instantiate.
    server_id: ?[]const u8 = null,

    /// The condition of the server that was described. A value of `ONLINE`
    /// indicates that the server can accept jobs and transfer files. A `State`
    /// value of `OFFLINE` means that the server cannot perform file transfer
    /// operations.
    ///
    /// The states of `STARTING` and `STOPPING` indicate that the server is in an
    /// intermediate state, either not fully able to respond, or not fully offline.
    /// The values of `START_FAILED` or `STOP_FAILED` can indicate an error
    /// condition.
    state: ?State = null,

    /// Specifies the log groups to which your server logs are sent.
    ///
    /// To specify a log group, you must provide the ARN for an existing log group.
    /// In this case, the format of the log group is as follows:
    ///
    /// `arn:aws:logs:region-name:amazon-account-id:log-group:log-group-name:*`
    ///
    /// For example, `arn:aws:logs:us-east-1:111122223333:log-group:mytestgroup:*`
    ///
    /// If you have previously specified a log group for a server, you can clear it,
    /// and in effect turn off structured logging, by providing an empty value for
    /// this parameter in an `update-server` call. For example:
    ///
    /// `update-server --server-id s-1234567890abcdef0
    /// --structured-log-destinations`
    structured_log_destinations: ?[]const []const u8 = null,

    /// Specifies the key-value pairs that you can use to search for and group
    /// servers that were assigned to the server that was described.
    tags: ?[]const Tag = null,

    /// Specifies the number of users that are assigned to a server you specified
    /// with the `ServerId`.
    user_count: ?i32 = null,

    /// Specifies the workflow ID for the workflow to assign and the execution role
    /// that's used for executing the workflow.
    ///
    /// In addition to a workflow to execute when a file is uploaded completely,
    /// `WorkflowDetails` can also contain a workflow ID (and execution role) for a
    /// workflow to execute on partial upload. A partial upload occurs when the
    /// server session disconnects while the file is still being uploaded.
    workflow_details: ?WorkflowDetails = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .as_2_service_managed_egress_ip_addresses = "As2ServiceManagedEgressIpAddresses",
        .certificate = "Certificate",
        .domain = "Domain",
        .endpoint_details = "EndpointDetails",
        .endpoint_type = "EndpointType",
        .host_key_fingerprint = "HostKeyFingerprint",
        .identity_provider_details = "IdentityProviderDetails",
        .identity_provider_type = "IdentityProviderType",
        .ip_address_type = "IpAddressType",
        .logging_role = "LoggingRole",
        .post_authentication_login_banner = "PostAuthenticationLoginBanner",
        .pre_authentication_login_banner = "PreAuthenticationLoginBanner",
        .protocol_details = "ProtocolDetails",
        .protocols = "Protocols",
        .s3_storage_options = "S3StorageOptions",
        .security_policy_name = "SecurityPolicyName",
        .server_id = "ServerId",
        .state = "State",
        .structured_log_destinations = "StructuredLogDestinations",
        .tags = "Tags",
        .user_count = "UserCount",
        .workflow_details = "WorkflowDetails",
    };
};
