const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const As2ConnectorConfig = @import("as_2_connector_config.zig").As2ConnectorConfig;
const UpdateConnectorEgressConfig = @import("update_connector_egress_config.zig").UpdateConnectorEgressConfig;
const SftpConnectorConfig = @import("sftp_connector_config.zig").SftpConnectorConfig;

pub const UpdateConnectorInput = struct {
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

    /// A structure that contains the parameters for an AS2 connector object.
    as_2_config: ?As2ConnectorConfig = null,

    /// The unique identifier for the connector.
    connector_id: []const u8,

    /// Updates the egress configuration for the connector, allowing you to modify
    /// how traffic is routed from the connector to the SFTP server. Changes to VPC
    /// configuration may require connector restart.
    egress_config: ?UpdateConnectorEgressConfig = null,

    /// The Amazon Resource Name (ARN) of the Identity and Access Management (IAM)
    /// role that allows a connector to turn on CloudWatch logging for Amazon S3
    /// events. When set, you can view connector activity in your CloudWatch logs.
    logging_role: ?[]const u8 = null,

    /// Specifies the name of the security policy for the connector.
    security_policy_name: ?[]const u8 = null,

    /// A structure that contains the parameters for an SFTP connector object.
    sftp_config: ?SftpConnectorConfig = null,

    /// The URL of the partner's AS2 or SFTP endpoint.
    ///
    /// When creating AS2 connectors or service-managed SFTP connectors (connectors
    /// without egress configuration), you must provide a URL to specify the remote
    /// server endpoint. For VPC Lattice type connectors, the URL must be null.
    url: ?[]const u8 = null,

    pub const json_field_names = .{
        .access_role = "AccessRole",
        .as_2_config = "As2Config",
        .connector_id = "ConnectorId",
        .egress_config = "EgressConfig",
        .logging_role = "LoggingRole",
        .security_policy_name = "SecurityPolicyName",
        .sftp_config = "SftpConfig",
        .url = "Url",
    };
};

pub const UpdateConnectorOutput = struct {
    /// Returns the identifier of the connector object that you are updating.
    connector_id: []const u8,

    pub const json_field_names = .{
        .connector_id = "ConnectorId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateConnectorInput, options: CallOptions) !UpdateConnectorOutput {
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
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateConnectorInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("transfer", "Transfer", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "TransferService.UpdateConnector");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateConnectorOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(UpdateConnectorOutput, body, allocator);
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
