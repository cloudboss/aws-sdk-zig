const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ExpirationTimeResponse = @import("expiration_time_response.zig").ExpirationTimeResponse;
const BatchGetRecordIdentifier = @import("batch_get_record_identifier.zig").BatchGetRecordIdentifier;
const BatchGetRecordError = @import("batch_get_record_error.zig").BatchGetRecordError;
const BatchGetRecordResultDetail = @import("batch_get_record_result_detail.zig").BatchGetRecordResultDetail;

pub const BatchGetRecordInput = struct {
    /// Parameter to request `ExpiresAt` in response. If `Enabled`,
    /// `BatchGetRecord` will return the value of `ExpiresAt`, if it is
    /// not null. If `Disabled` and null, `BatchGetRecord` will return
    /// null.
    expiration_time_response: ?ExpirationTimeResponse = null,

    /// A list containing the name or Amazon Resource Name (ARN) of the
    /// `FeatureGroup`, the list of names of `Feature`s to be retrieved,
    /// and the corresponding `RecordIdentifier` values as strings.
    identifiers: []const BatchGetRecordIdentifier,

    pub const json_field_names = .{
        .expiration_time_response = "ExpirationTimeResponse",
        .identifiers = "Identifiers",
    };
};

pub const BatchGetRecordOutput = struct {
    /// A list of errors that have occurred when retrieving a batch of Records.
    errors: ?[]const BatchGetRecordError = null,

    /// A list of Records you requested to be retrieved in batch.
    records: ?[]const BatchGetRecordResultDetail = null,

    /// A unprocessed list of `FeatureGroup` names, with their corresponding
    /// `RecordIdentifier` value, and Feature name.
    unprocessed_identifiers: ?[]const BatchGetRecordIdentifier = null,

    pub const json_field_names = .{
        .errors = "Errors",
        .records = "Records",
        .unprocessed_identifiers = "UnprocessedIdentifiers",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchGetRecordInput, options: CallOptions) !BatchGetRecordOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "sagemaker");

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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchGetRecordInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("featurestore-runtime.sagemaker", "SageMaker FeatureStore Runtime", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/BatchGetRecord";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.expiration_time_response) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ExpirationTimeResponse\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Identifiers\":");
    try aws.json.writeValue(@TypeOf(input.identifiers), input.identifiers, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchGetRecordOutput {
    var result: BatchGetRecordOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(BatchGetRecordOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
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

    if (std.mem.eql(u8, error_code, "AccessForbidden")) {
        return .{ .arena = arena, .kind = .{ .access_forbidden = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalFailure")) {
        return .{ .arena = arena, .kind = .{ .internal_failure = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFound")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceUnavailable")) {
        return .{ .arena = arena, .kind = .{ .service_unavailable = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationError")) {
        return .{ .arena = arena, .kind = .{ .validation_error = .{
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
