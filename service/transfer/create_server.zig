const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const Domain = @import("domain.zig").Domain;
const EndpointDetails = @import("endpoint_details.zig").EndpointDetails;
const EndpointType = @import("endpoint_type.zig").EndpointType;
const IdentityProviderDetails = @import("identity_provider_details.zig").IdentityProviderDetails;
const IdentityProviderType = @import("identity_provider_type.zig").IdentityProviderType;
const IpAddressType = @import("ip_address_type.zig").IpAddressType;
const ProtocolDetails = @import("protocol_details.zig").ProtocolDetails;
const Protocol = @import("protocol.zig").Protocol;
const S3StorageOptions = @import("s3_storage_options.zig").S3StorageOptions;
const Tag = @import("tag.zig").Tag;
const WorkflowDetails = @import("workflow_details.zig").WorkflowDetails;

pub const CreateServerInput = struct {
    /// The Amazon Resource Name (ARN) of the Certificate Manager (ACM) certificate.
    /// Required when `Protocols` is set to `FTPS`.
    ///
    /// To request a new public certificate, see [Request a public
    /// certificate](https://docs.aws.amazon.com/acm/latest/userguide/gs-acm-request-public.html) in the *Certificate Manager User Guide*.
    ///
    /// To import an existing certificate into ACM, see [Importing certificates into
    /// ACM](https://docs.aws.amazon.com/acm/latest/userguide/import-certificate.html) in the *Certificate Manager User Guide*.
    ///
    /// To request a private certificate to use FTPS through private IP addresses,
    /// see [Request a private
    /// certificate](https://docs.aws.amazon.com/acm/latest/userguide/gs-acm-request-private.html) in the *Certificate Manager User Guide*.
    ///
    /// Certificates with the following cryptographic algorithms and key sizes are
    /// supported:
    ///
    /// * 2048-bit RSA (RSA_2048)
    /// * 4096-bit RSA (RSA_4096)
    /// * Elliptic Prime Curve 256 bit (EC_prime256v1)
    /// * Elliptic Prime Curve 384 bit (EC_secp384r1)
    /// * Elliptic Prime Curve 521 bit (EC_secp521r1)
    ///
    /// The certificate must be a valid SSL/TLS X.509 version 3 certificate with
    /// FQDN or IP address specified and information about the issuer.
    certificate: ?[]const u8 = null,

    /// The domain of the storage system that is used for file transfers. There are
    /// two domains available: Amazon Simple Storage Service (Amazon S3) and Amazon
    /// Elastic File System (Amazon EFS). The default value is S3.
    ///
    /// After the server is created, the domain cannot be changed.
    domain: ?Domain = null,

    /// The virtual private cloud (VPC) endpoint settings that are configured for
    /// your server. When you host your endpoint within your VPC, you can make your
    /// endpoint accessible only to resources within your VPC, or you can attach
    /// Elastic IP addresses and make your endpoint accessible to clients over the
    /// internet. Your VPC's default security groups are automatically assigned to
    /// your endpoint.
    endpoint_details: ?EndpointDetails = null,

    /// The type of endpoint that you want your server to use. You can choose to
    /// make your server's endpoint publicly accessible (PUBLIC) or host it inside
    /// your VPC. With an endpoint that is hosted in a VPC, you can restrict access
    /// to your server and resources only within your VPC or choose to make it
    /// internet facing by attaching Elastic IP addresses directly to it.
    ///
    /// After May 19, 2021, you won't be able to create a server using
    /// `EndpointType=VPC_ENDPOINT` in your Amazon Web Services account if your
    /// account hasn't already done so before May 19, 2021. If you have already
    /// created servers with `EndpointType=VPC_ENDPOINT` in your Amazon Web Services
    /// account on or before May 19, 2021, you will not be affected. After this
    /// date, use `EndpointType`=`VPC`.
    ///
    /// For more information, see
    /// https://docs.aws.amazon.com/transfer/latest/userguide/create-server-in-vpc.html#deprecate-vpc-endpoint.
    ///
    /// It is recommended that you use `VPC` as the `EndpointType`. With this
    /// endpoint type, you have the option to directly associate up to three Elastic
    /// IPv4 addresses (BYO IP included) with your server's endpoint and use VPC
    /// security groups to restrict traffic by the client's public IP address. This
    /// is not possible with `EndpointType` set to `VPC_ENDPOINT`.
    endpoint_type: ?EndpointType = null,

    /// The RSA, ECDSA, or ED25519 private key to use for your SFTP-enabled server.
    /// You can add multiple host keys, in case you want to rotate keys, or have a
    /// set of active keys that use different algorithms.
    ///
    /// Use the following command to generate an RSA 2048 bit key with no
    /// passphrase:
    ///
    /// `ssh-keygen -t rsa -b 2048 -N "" -m PEM -f my-new-server-key`.
    ///
    /// Use a minimum value of 2048 for the `-b` option. You can create a stronger
    /// key by using 3072 or 4096.
    ///
    /// Use the following command to generate an ECDSA 256 bit key with no
    /// passphrase:
    ///
    /// `ssh-keygen -t ecdsa -b 256 -N "" -m PEM -f my-new-server-key`.
    ///
    /// Valid values for the `-b` option for ECDSA are 256, 384, and 521.
    ///
    /// Use the following command to generate an ED25519 key with no passphrase:
    ///
    /// `ssh-keygen -t ed25519 -N "" -f my-new-server-key`.
    ///
    /// For all of these commands, you can replace *my-new-server-key* with a string
    /// of your choice.
    ///
    /// If you aren't planning to migrate existing users from an existing
    /// SFTP-enabled server to a new server, don't update the host key. Accidentally
    /// changing a server's host key can be disruptive.
    ///
    /// For more information, see [Manage host keys for your SFTP-enabled
    /// server](https://docs.aws.amazon.com/transfer/latest/userguide/edit-server-config.html#configuring-servers-change-host-key) in the *Transfer Family User Guide*.
    host_key: ?[]const u8 = null,

    /// Required when `IdentityProviderType` is set to `AWS_DIRECTORY_SERVICE`,
    /// `Amazon Web Services_LAMBDA` or `API_GATEWAY`. Accepts an array containing
    /// all of the information required to use a directory in
    /// `AWS_DIRECTORY_SERVICE` or invoke a customer-supplied authentication API,
    /// including the API Gateway URL. Cannot be specified when
    /// `IdentityProviderType` is set to `SERVICE_MANAGED`.
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

    /// Key-value pairs that can be used to group and search for servers.
    tags: ?[]const Tag = null,

    /// Specifies the workflow ID for the workflow to assign and the execution role
    /// that's used for executing the workflow.
    ///
    /// In addition to a workflow to execute when a file is uploaded completely,
    /// `WorkflowDetails` can also contain a workflow ID (and execution role) for a
    /// workflow to execute on partial upload. A partial upload occurs when the
    /// server session disconnects while the file is still being uploaded.
    workflow_details: ?WorkflowDetails = null,

    pub const json_field_names = .{
        .certificate = "Certificate",
        .domain = "Domain",
        .endpoint_details = "EndpointDetails",
        .endpoint_type = "EndpointType",
        .host_key = "HostKey",
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
        .structured_log_destinations = "StructuredLogDestinations",
        .tags = "Tags",
        .workflow_details = "WorkflowDetails",
    };
};

pub const CreateServerOutput = struct {
    /// The service-assigned identifier of the server that is created.
    server_id: []const u8,

    pub const json_field_names = .{
        .server_id = "ServerId",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateServerInput, options: Options) !CreateServerOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "transfer");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: CreateServerInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("transfer", "Transfer", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(alloc, "X-Amz-Target", "TransferService.CreateServer");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateServerOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateServerOutput, body, alloc);
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServiceError")) {
        return .{ .arena = arena, .kind = .{ .internal_service_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidNextTokenException")) {
        return .{ .arena = arena, .kind = .{ .invalid_next_token_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRequestException")) {
        return .{ .arena = arena, .kind = .{ .invalid_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceExistsException")) {
        return .{ .arena = arena, .kind = .{ .resource_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .service_unavailable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
