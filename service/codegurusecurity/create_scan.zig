const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const AnalysisType = @import("analysis_type.zig").AnalysisType;
const ResourceId = @import("resource_id.zig").ResourceId;
const ScanType = @import("scan_type.zig").ScanType;
const ScanState = @import("scan_state.zig").ScanState;

pub const CreateScanInput = struct {
    /// The type of analysis you want CodeGuru Security to perform in the scan,
    /// either `Security` or `All`. The `Security` type only generates findings
    /// related to security. The `All` type generates both security findings and
    /// quality findings. Defaults to `Security` type if missing.
    analysis_type: ?AnalysisType = null,

    /// The idempotency token for the request. Amazon CodeGuru Security uses this
    /// value to prevent the accidental creation of duplicate scans if there are
    /// failures and retries.
    client_token: ?[]const u8 = null,

    /// The identifier for the resource object to be scanned.
    resource_id: ResourceId,

    /// The unique name that CodeGuru Security uses to track revisions across
    /// multiple scans of the same resource. Only allowed for a `STANDARD` scan
    /// type.
    scan_name: []const u8,

    /// The type of scan, either `Standard` or `Express`. Defaults to `Standard`
    /// type if missing.
    ///
    /// `Express` scans run on limited resources and use a limited set of detectors
    /// to analyze your code in near-real time. `Standard` scans have standard
    /// resource limits and use the full set of detectors to analyze your code.
    scan_type: ?ScanType = null,

    /// An array of key-value pairs used to tag a scan. A tag is a custom attribute
    /// label with two parts:
    ///
    /// * A tag key. For example, `CostCenter`, `Environment`, or `Secret`. Tag keys
    ///   are case sensitive.
    /// * An optional tag value field. For example, `111122223333`, `Production`, or
    ///   a team name. Omitting the tag value is the same as using an empty string.
    ///   Tag values are case sensitive.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .analysis_type = "analysisType",
        .client_token = "clientToken",
        .resource_id = "resourceId",
        .scan_name = "scanName",
        .scan_type = "scanType",
        .tags = "tags",
    };
};

pub const CreateScanOutput = struct {
    /// The identifier for the resource object that contains resources that were
    /// scanned.
    resource_id: ?ResourceId = null,

    /// UUID that identifies the individual scan run.
    run_id: []const u8,

    /// The name of the scan.
    scan_name: []const u8,

    /// The ARN for the scan name.
    scan_name_arn: ?[]const u8 = null,

    /// The current state of the scan. Returns either `InProgress`, `Successful`, or
    /// `Failed`.
    scan_state: ScanState,

    pub const json_field_names = .{
        .resource_id = "resourceId",
        .run_id = "runId",
        .scan_name = "scanName",
        .scan_name_arn = "scanNameArn",
        .scan_state = "scanState",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateScanInput, options: CallOptions) !CreateScanOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "codeguru-security");

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateScanInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codeguru-security", "CodeGuru Security", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/scans";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.analysis_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"analysisType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"resourceId\":");
    try aws.json.writeValue(@TypeOf(input.resource_id), input.resource_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"scanName\":");
    try aws.json.writeValue(@TypeOf(input.scan_name), input.scan_name, allocator, &body_buf);
    has_prev = true;
    if (input.scan_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"scanType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateScanOutput {
    var result: CreateScanOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateScanOutput, body, allocator);
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
