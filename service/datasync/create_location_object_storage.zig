const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const CmkSecretConfig = @import("cmk_secret_config.zig").CmkSecretConfig;
const CustomSecretConfig = @import("custom_secret_config.zig").CustomSecretConfig;
const ObjectStorageServerProtocol = @import("object_storage_server_protocol.zig").ObjectStorageServerProtocol;
const TagListEntry = @import("tag_list_entry.zig").TagListEntry;

pub const CreateLocationObjectStorageInput = struct {
    /// Specifies the access key (for example, a user name) if credentials are
    /// required to
    /// authenticate with the object storage server.
    access_key: ?[]const u8 = null,

    /// (Optional) Specifies the Amazon Resource Names (ARNs) of the DataSync agents
    /// that can connect with your object storage system. If you are setting up an
    /// agentless
    /// cross-cloud transfer, you do not need to specify a value for this parameter.
    ///
    /// Make sure you configure this parameter correctly when you first create your
    /// storage
    /// location. You cannot add or remove agents from a storage location after you
    /// create
    /// it.
    agent_arns: ?[]const []const u8 = null,

    /// Specifies the name of the object storage bucket involved in the transfer.
    bucket_name: []const u8,

    /// Specifies configuration information for a DataSync-managed secret, which
    /// includes the `SecretKey` that DataSync uses to access a specific object
    /// storage location, with a customer-managed KMS key.
    ///
    /// When you include this parameter as part of a `CreateLocationObjectStorage`
    /// request, you provide only the KMS key ARN. DataSync uses this KMS key
    /// together with the value you specify for the `SecretKey` parameter
    /// to create a DataSync-managed secret to store the location access
    /// credentials.
    ///
    /// Make sure that DataSync has permission to access the KMS key that
    /// you specify.
    ///
    /// You can use either `CmkSecretConfig` (with `SecretKey`) or
    /// `CustomSecretConfig` (without `SecretKey`) to provide credentials
    /// for a `CreateLocationObjectStorage` request. Do not provide both parameters
    /// for
    /// the same request.
    cmk_secret_config: ?CmkSecretConfig = null,

    /// Specifies configuration information for a customer-managed Secrets Manager
    /// secret where
    /// the secret key for a specific object storage location is stored in plain
    /// text, in Secrets Manager.
    /// This configuration includes the secret ARN, and the ARN for an IAM role that
    /// provides access to the secret.
    ///
    /// You can use either `CmkSecretConfig` (with `SecretKey`) or
    /// `CustomSecretConfig` (without `SecretKey`) to provide credentials
    /// for a `CreateLocationObjectStorage` request. Do not provide both parameters
    /// for
    /// the same request.
    custom_secret_config: ?CustomSecretConfig = null,

    /// Specifies the secret key (for example, a password) if credentials are
    /// required to
    /// authenticate with the object storage server.
    ///
    /// If you provide a secret using `SecretKey`, but do not provide secret
    /// configuration details using `CmkSecretConfig` or `CustomSecretConfig`,
    /// then DataSync stores the token using your Amazon Web Services account's
    /// Secrets Manager secret.
    secret_key: ?[]const u8 = null,

    /// Specifies a certificate chain for DataSync to authenticate with your object
    /// storage system if the system uses a private or self-signed certificate
    /// authority (CA). You
    /// must specify a single `.pem` file with a full certificate chain (for
    /// example,
    /// `file:///home/user/.ssh/object_storage_certificates.pem`).
    ///
    /// The certificate chain might include:
    ///
    /// * The object storage system's certificate
    ///
    /// * All intermediate certificates (if there are any)
    ///
    /// * The root certificate of the signing CA
    ///
    /// You can concatenate your certificates into a `.pem` file (which can be up to
    /// 32768 bytes before base64 encoding). The following example `cat` command
    /// creates an
    /// `object_storage_certificates.pem` file that includes three certificates:
    ///
    /// `cat object_server_certificate.pem intermediate_certificate.pem
    /// ca_root_certificate.pem > object_storage_certificates.pem`
    ///
    /// To use this parameter, configure `ServerProtocol` to `HTTPS`.
    server_certificate: ?[]const u8 = null,

    /// Specifies the domain name or IP address (IPv4 or IPv6) of the object storage
    /// server that
    /// your DataSync agent connects to.
    server_hostname: []const u8,

    /// Specifies the port that your object storage server accepts inbound network
    /// traffic on (for
    /// example, port 443).
    server_port: ?i32 = null,

    /// Specifies the protocol that your object storage server uses to communicate.
    /// If not specified, the default
    /// value is `HTTPS`.
    server_protocol: ?ObjectStorageServerProtocol = null,

    /// Specifies the object prefix for your object storage server. If this is a
    /// source location,
    /// DataSync only copies objects with this prefix. If this is a destination
    /// location,
    /// DataSync writes all objects with this prefix.
    subdirectory: ?[]const u8 = null,

    /// Specifies the key-value pair that represents a tag that you want to add to
    /// the resource.
    /// Tags can help you manage, filter, and search for your resources. We
    /// recommend creating a name
    /// tag for your location.
    tags: ?[]const TagListEntry = null,

    pub const json_field_names = .{
        .access_key = "AccessKey",
        .agent_arns = "AgentArns",
        .bucket_name = "BucketName",
        .cmk_secret_config = "CmkSecretConfig",
        .custom_secret_config = "CustomSecretConfig",
        .secret_key = "SecretKey",
        .server_certificate = "ServerCertificate",
        .server_hostname = "ServerHostname",
        .server_port = "ServerPort",
        .server_protocol = "ServerProtocol",
        .subdirectory = "Subdirectory",
        .tags = "Tags",
    };
};

pub const CreateLocationObjectStorageOutput = struct {
    /// Specifies the ARN of the object storage system location that you create.
    location_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .location_arn = "LocationArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateLocationObjectStorageInput, options: CallOptions) !CreateLocationObjectStorageOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateLocationObjectStorageInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "FmrsService.CreateLocationObjectStorage");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateLocationObjectStorageOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateLocationObjectStorageOutput, body, allocator);
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
