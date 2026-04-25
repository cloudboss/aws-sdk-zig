const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const SmbAuthenticationType = @import("smb_authentication_type.zig").SmbAuthenticationType;
const CmkSecretConfig = @import("cmk_secret_config.zig").CmkSecretConfig;
const CustomSecretConfig = @import("custom_secret_config.zig").CustomSecretConfig;
const SmbMountOptions = @import("smb_mount_options.zig").SmbMountOptions;

pub const UpdateLocationSmbInput = struct {
    /// Specifies the DataSync agent (or agents) that can connect to your SMB file
    /// server. You specify an agent by using its Amazon Resource Name (ARN).
    agent_arns: ?[]const []const u8 = null,

    /// Specifies the authentication protocol that DataSync uses to connect to your
    /// SMB
    /// file server. DataSync supports `NTLM` (default) and `KERBEROS`
    /// authentication.
    ///
    /// For more information, see [Providing DataSync access to SMB file
    /// servers](https://docs.aws.amazon.com/datasync/latest/userguide/create-smb-location.html#configuring-smb-permissions).
    authentication_type: ?SmbAuthenticationType = null,

    /// Specifies configuration information for a DataSync-managed secret, such as a
    /// `Password` or `KerberosKeytab` or set of credentials that DataSync uses to
    /// access a specific transfer location, and a
    /// customer-managed KMS key.
    cmk_secret_config: ?CmkSecretConfig = null,

    /// Specifies configuration information for a customer-managed secret, such as a
    /// `Password` or `KerberosKeytab` or set of credentials that DataSync uses to
    /// access a specific transfer location, and a
    /// customer-managed Identity and Access Management (IAM) role that provides
    /// access to
    /// the secret.
    custom_secret_config: ?CustomSecretConfig = null,

    /// Specifies the IP addresses (IPv4 or IPv6) for the DNS servers that your SMB
    /// file server belongs to.
    /// This parameter applies only if `AuthenticationType` is set to
    /// `KERBEROS`.
    ///
    /// If you have multiple domains in your environment, configuring this parameter
    /// makes sure
    /// that DataSync connects to the right SMB file server.
    dns_ip_addresses: ?[]const []const u8 = null,

    /// Specifies the Windows domain name that your SMB file server belongs to. This
    /// parameter
    /// applies only if `AuthenticationType` is set to `NTLM`.
    ///
    /// If you have multiple domains in your environment, configuring this parameter
    /// makes sure
    /// that DataSync connects to the right file server.
    domain: ?[]const u8 = null,

    /// Specifies your Kerberos key table (keytab) file, which includes mappings
    /// between your
    /// Kerberos principal and encryption keys.
    ///
    /// To avoid task execution errors, make sure that the Kerberos principal that
    /// you use to
    /// create the keytab file matches exactly what you specify for
    /// `KerberosPrincipal`.
    kerberos_keytab: ?[]const u8 = null,

    /// Specifies a Kerberos configuration file (`krb5.conf`) that defines your
    /// Kerberos realm configuration.
    ///
    /// The file must be base64 encoded. If you're using the CLI, the encoding is
    /// done for you.
    kerberos_krb_5_conf: ?[]const u8 = null,

    /// Specifies a Kerberos prinicpal, which is an identity in your Kerberos realm
    /// that has
    /// permission to access the files, folders, and file metadata in your SMB file
    /// server.
    ///
    /// A Kerberos principal might look like `HOST/kerberosuser@MYDOMAIN.ORG`.
    ///
    /// Principal names are case sensitive. Your DataSync task execution will fail
    /// if
    /// the principal that you specify for this parameter doesn’t exactly match the
    /// principal that you
    /// use to create the keytab file.
    kerberos_principal: ?[]const u8 = null,

    /// Specifies the ARN of the SMB location that you want to update.
    location_arn: []const u8,

    mount_options: ?SmbMountOptions = null,

    /// Specifies the password of the user who can mount your SMB file server and
    /// has permission
    /// to access the files and folders involved in your transfer. This parameter
    /// applies only if
    /// `AuthenticationType` is set to `NTLM`.
    password: ?[]const u8 = null,

    /// Specifies the domain name or IP address (IPv4 or IPv6) of the SMB file
    /// server that your DataSync agent connects to.
    ///
    /// If you're using Kerberos authentication, you must specify a domain name.
    server_hostname: ?[]const u8 = null,

    /// Specifies the name of the share exported by your SMB file server where
    /// DataSync
    /// will read or write data. You can include a subdirectory in the share path
    /// (for example,
    /// `/path/to/subdirectory`). Make sure that other SMB clients in your network
    /// can
    /// also mount this path.
    ///
    /// To copy all data in the specified subdirectory, DataSync must be able to
    /// mount
    /// the SMB share and access all of its data. For more information, see
    /// [Providing DataSync access to SMB file
    /// servers](https://docs.aws.amazon.com/datasync/latest/userguide/create-smb-location.html#configuring-smb-permissions).
    subdirectory: ?[]const u8 = null,

    /// Specifies the user name that can mount your SMB file server and has
    /// permission to access
    /// the files and folders involved in your transfer. This parameter applies only
    /// if
    /// `AuthenticationType` is set to `NTLM`.
    ///
    /// For information about choosing a user with the right level of access for
    /// your transfer,
    /// see [Providing DataSync access to SMB file
    /// servers](https://docs.aws.amazon.com/datasync/latest/userguide/create-smb-location.html#configuring-smb-permissions).
    user: ?[]const u8 = null,

    pub const json_field_names = .{
        .agent_arns = "AgentArns",
        .authentication_type = "AuthenticationType",
        .cmk_secret_config = "CmkSecretConfig",
        .custom_secret_config = "CustomSecretConfig",
        .dns_ip_addresses = "DnsIpAddresses",
        .domain = "Domain",
        .kerberos_keytab = "KerberosKeytab",
        .kerberos_krb_5_conf = "KerberosKrb5Conf",
        .kerberos_principal = "KerberosPrincipal",
        .location_arn = "LocationArn",
        .mount_options = "MountOptions",
        .password = "Password",
        .server_hostname = "ServerHostname",
        .subdirectory = "Subdirectory",
        .user = "User",
    };
};

pub const UpdateLocationSmbOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateLocationSmbInput, options: CallOptions) !UpdateLocationSmbOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "datasync");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateLocationSmbInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datasync", "DataSync", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "FmrsService.UpdateLocationSmb");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateLocationSmbOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "InternalException")) {
        return .{ .arena = arena, .kind = .{ .internal_exception = .{
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

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
