const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const SmbAuthenticationType = @import("smb_authentication_type.zig").SmbAuthenticationType;
const CmkSecretConfig = @import("cmk_secret_config.zig").CmkSecretConfig;
const CustomSecretConfig = @import("custom_secret_config.zig").CustomSecretConfig;
const ManagedSecretConfig = @import("managed_secret_config.zig").ManagedSecretConfig;
const SmbMountOptions = @import("smb_mount_options.zig").SmbMountOptions;

pub const DescribeLocationSmbInput = struct {
    /// Specifies the Amazon Resource Name (ARN) of the SMB location that you want
    /// information
    /// about.
    location_arn: []const u8,

    pub const json_field_names = .{
        .location_arn = "LocationArn",
    };
};

pub const DescribeLocationSmbOutput = struct {
    /// The ARNs of the DataSync agents that can connect with your SMB file
    /// server.
    agent_arns: ?[]const []const u8 = null,

    /// The authentication protocol that DataSync uses to connect to your SMB file
    /// server.
    authentication_type: ?SmbAuthenticationType = null,

    /// Describes configuration information for a DataSync-managed secret, such as a
    /// `Password` or `KerberosKeytab` that DataSync uses to access
    /// a specific storage location, with a customer-managed KMS key.
    cmk_secret_config: ?CmkSecretConfig = null,

    /// The time that the SMB location was created.
    creation_time: ?i64 = null,

    /// Describes configuration information for a customer-managed secret, such as a
    /// `Password` or `KerberosKeytab` that DataSync uses to access
    /// a specific storage location, with a customer-managed KMS key.
    custom_secret_config: ?CustomSecretConfig = null,

    /// The IPv4 or IPv6 addresses for the DNS servers that your SMB file server
    /// belongs to. This element
    /// applies only if `AuthenticationType` is set to `KERBEROS`.
    dns_ip_addresses: ?[]const []const u8 = null,

    /// The name of the Windows domain that the SMB file server belongs to. This
    /// element applies
    /// only if `AuthenticationType` is set to `NTLM`.
    domain: ?[]const u8 = null,

    /// The Kerberos principal that has permission to access the files, folders, and
    /// file metadata
    /// in your SMB file server.
    kerberos_principal: ?[]const u8 = null,

    /// The ARN of the SMB location.
    location_arn: ?[]const u8 = null,

    /// The URI of the SMB location.
    location_uri: ?[]const u8 = null,

    /// Describes configuration information for a DataSync-managed secret, such as a
    /// `Password` or `KerberosKeytab` that DataSync uses to access
    /// a specific storage location. DataSync uses the default Amazon Web
    /// Services-managed
    /// KMS key to encrypt this secret in Secrets Manager.
    managed_secret_config: ?ManagedSecretConfig = null,

    /// The SMB protocol version that DataSync uses to access your SMB file
    /// server.
    mount_options: ?SmbMountOptions = null,

    /// The user that can mount and access the files, folders, and file metadata in
    /// your SMB file
    /// server. This element applies only if `AuthenticationType` is set to
    /// `NTLM`.
    user: ?[]const u8 = null,

    pub const json_field_names = .{
        .agent_arns = "AgentArns",
        .authentication_type = "AuthenticationType",
        .cmk_secret_config = "CmkSecretConfig",
        .creation_time = "CreationTime",
        .custom_secret_config = "CustomSecretConfig",
        .dns_ip_addresses = "DnsIpAddresses",
        .domain = "Domain",
        .kerberos_principal = "KerberosPrincipal",
        .location_arn = "LocationArn",
        .location_uri = "LocationUri",
        .managed_secret_config = "ManagedSecretConfig",
        .mount_options = "MountOptions",
        .user = "User",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeLocationSmbInput, options: CallOptions) !DescribeLocationSmbOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeLocationSmbInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "FmrsService.DescribeLocationSmb");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeLocationSmbOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeLocationSmbOutput, body, allocator);
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
