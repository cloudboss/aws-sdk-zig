const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ConnectorFileTransferResult = @import("connector_file_transfer_result.zig").ConnectorFileTransferResult;

pub const ListFileTransferResultsInput = struct {
    /// A unique identifier for a connector. This value should match the value
    /// supplied to the corresponding `StartFileTransfer` call.
    connector_id: []const u8,

    /// The maximum number of files to return in a single page. Note that currently
    /// you can specify a maximum of 10 file paths in a single
    /// [StartFileTransfer](https://docs.aws.amazon.com/transfer/latest/APIReference/API_StartFileTransfer.html) operation. Thus, the maximum number of file transfer results that can be returned in a single page is 10.
    max_results: ?i32 = null,

    /// If there are more file details than returned in this call, use this value
    /// for a subsequent call to `ListFileTransferResults` to retrieve them.
    next_token: ?[]const u8 = null,

    /// A unique identifier for a file transfer. This value should match the value
    /// supplied to the corresponding `StartFileTransfer` call.
    transfer_id: []const u8,

    pub const json_field_names = .{
        .connector_id = "ConnectorId",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .transfer_id = "TransferId",
    };
};

pub const ListFileTransferResultsOutput = struct {
    /// Returns the details for the files transferred in the transfer identified by
    /// the `TransferId` and `ConnectorId` specified.
    ///
    /// * `FilePath`: the filename and path to where the file was sent to or
    ///   retrieved from.
    /// * `StatusCode`: current status for the transfer. The status returned is one
    ///   of the following values:`QUEUED`, `IN_PROGRESS`, `COMPLETED`, or `FAILED`
    /// * `FailureCode`: for transfers that fail, this parameter contains a code
    ///   indicating the reason. For example, `RETRIEVE_FILE_NOT_FOUND`
    /// * `FailureMessage`: for transfers that fail, this parameter describes the
    ///   reason for the failure.
    file_transfer_results: ?[]const ConnectorFileTransferResult = null,

    /// Returns a token that you can use to call `ListFileTransferResults` again and
    /// receive additional results, if there are any (against the same `TransferId`.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .file_transfer_results = "FileTransferResults",
        .next_token = "NextToken",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListFileTransferResultsInput, options: Options) !ListFileTransferResultsOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: ListFileTransferResultsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(alloc, "X-Amz-Target", "TransferService.ListFileTransferResults");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !ListFileTransferResultsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListFileTransferResultsOutput, body, alloc);
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
