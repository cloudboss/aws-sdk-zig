const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ProcessingType = @import("processing_type.zig").ProcessingType;
const Record = @import("record.zig").Record;
const FailedRecord = @import("failed_record.zig").FailedRecord;
const MatchGroup = @import("match_group.zig").MatchGroup;

pub const GenerateMatchIdInput = struct {
    /// The processing mode that determines how Match IDs are generated and results
    /// are saved. Each mode provides different levels of accuracy, response time,
    /// and completeness of results.
    ///
    /// If not specified, defaults to `CONSISTENT`.
    ///
    /// `CONSISTENT`: Performs immediate lookup and matching against all existing
    /// records, with results saved synchronously. Provides highest accuracy but
    /// slower response time.
    ///
    /// `EVENTUAL` (shown as *Background* in the console): Performs initial match ID
    /// lookup or generation immediately, with record updates processed
    /// asynchronously in the background. Offers faster initial response time, with
    /// complete matching results available later in S3.
    ///
    /// `EVENTUAL_NO_LOOKUP` (shown as *Quick ID generation* in the console):
    /// Generates new match IDs without checking existing matches, with updates
    /// processed asynchronously. Provides fastest response time but should only be
    /// used for records known to be unique.
    processing_type: ?ProcessingType = null,

    /// The records to match.
    records: []const Record,

    /// The name of the rule-based matching workflow.
    workflow_name: []const u8,

    pub const json_field_names = .{
        .processing_type = "processingType",
        .records = "records",
        .workflow_name = "workflowName",
    };
};

pub const GenerateMatchIdOutput = struct {
    /// The records that didn't receive a generated Match ID.
    failed_records: ?[]const FailedRecord = null,

    /// The match groups from the generated match ID.
    match_groups: ?[]const MatchGroup = null,

    pub const json_field_names = .{
        .failed_records = "failedRecords",
        .match_groups = "matchGroups",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GenerateMatchIdInput, options: Options) !GenerateMatchIdOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "entityresolution");

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

fn serializeRequest(alloc: std.mem.Allocator, input: GenerateMatchIdInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("entityresolution", "EntityResolution", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/matchingworkflows/");
    try path_buf.appendSlice(alloc, input.workflow_name);
    try path_buf.appendSlice(alloc, "/generateMatches");
    const path = try path_buf.toOwnedSlice(alloc);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (input.processing_type) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"processingType\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"records\":");
    try aws.json.writeValue(@TypeOf(input.records), input.records, alloc, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(alloc, "}");
    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GenerateMatchIdOutput {
    var result: GenerateMatchIdOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GenerateMatchIdOutput, body, alloc);
    }
    _ = status;
    _ = headers;

    return result;
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
    if (std.mem.eql(u8, error_code, "ExceedsLimitException")) {
        return .{ .arena = arena, .kind = .{ .exceeds_limit_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
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
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
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
