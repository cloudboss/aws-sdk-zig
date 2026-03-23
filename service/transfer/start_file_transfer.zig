const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const CustomHttpHeader = @import("custom_http_header.zig").CustomHttpHeader;

pub const StartFileTransferInput = struct {
    /// The unique identifier for the connector.
    connector_id: []const u8,

    /// An array of key-value pairs that represent custom HTTP headers to include in
    /// AS2 messages. These headers are added to the AS2 message when sending files
    /// to your trading partner.
    custom_http_headers: ?[]const CustomHttpHeader = null,

    /// For an inbound transfer, the `LocaDirectoryPath` specifies the destination
    /// for one or more files that are transferred from the partner's SFTP server.
    local_directory_path: ?[]const u8 = null,

    /// For an outbound transfer, the `RemoteDirectoryPath` specifies the
    /// destination for one or more files that are transferred to the partner's SFTP
    /// server. If you don't specify a `RemoteDirectoryPath`, the destination for
    /// transferred files is the SFTP user's home directory.
    remote_directory_path: ?[]const u8 = null,

    /// One or more source paths for the partner's SFTP server. Each string
    /// represents a source file path for one inbound file transfer.
    retrieve_file_paths: ?[]const []const u8 = null,

    /// One or more source paths for the Amazon S3 storage. Each string represents a
    /// source file path for one outbound file transfer. For example, `
    /// *amzn-s3-demo-bucket*/*myfile.txt* `.
    ///
    /// Replace ` *amzn-s3-demo-bucket* ` with one of your actual buckets.
    send_file_paths: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .connector_id = "ConnectorId",
        .custom_http_headers = "CustomHttpHeaders",
        .local_directory_path = "LocalDirectoryPath",
        .remote_directory_path = "RemoteDirectoryPath",
        .retrieve_file_paths = "RetrieveFilePaths",
        .send_file_paths = "SendFilePaths",
    };
};

pub const StartFileTransferOutput = struct {
    /// Returns the unique identifier for the file transfer.
    transfer_id: []const u8,

    pub const json_field_names = .{
        .transfer_id = "TransferId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartFileTransferInput, options: CallOptions) !StartFileTransferOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartFileTransferInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "TransferService.StartFileTransfer");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartFileTransferOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(StartFileTransferOutput, body, allocator);
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
