const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const MetadataGenerationRunTarget = @import("metadata_generation_run_target.zig").MetadataGenerationRunTarget;
const MetadataGenerationRunType = @import("metadata_generation_run_type.zig").MetadataGenerationRunType;
const MetadataGenerationRunStatus = @import("metadata_generation_run_status.zig").MetadataGenerationRunStatus;

pub const StartMetadataGenerationRunInput = struct {
    /// A unique, case-sensitive identifier to ensure idempotency of the request.
    /// This field is automatically populated if not provided.
    client_token: ?[]const u8 = null,

    /// The ID of the Amazon DataZone domain where you want to start a metadata
    /// generation run.
    domain_identifier: []const u8,

    /// The ID of the project that owns the asset for which you want to start a
    /// metadata generation run.
    owning_project_identifier: []const u8,

    /// The asset for which you want to start a metadata generation run.
    target: MetadataGenerationRunTarget,

    /// The type of the metadata generation run.
    @"type": ?MetadataGenerationRunType = null,

    /// The types of the metadata generation run.
    types: ?[]const MetadataGenerationRunType = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .domain_identifier = "domainIdentifier",
        .owning_project_identifier = "owningProjectIdentifier",
        .target = "target",
        .@"type" = "type",
        .types = "types",
    };
};

pub const StartMetadataGenerationRunOutput = struct {
    /// The timestamp at which the metadata generation run was started.
    created_at: ?i64 = null,

    /// The ID of the user who started the metadata generation run.
    created_by: ?[]const u8 = null,

    /// The ID of the Amazon DataZone domain in which the metadata generation run
    /// was started.
    domain_id: []const u8,

    /// The ID of the metadata generation run.
    id: []const u8,

    /// The ID of the project that owns the asset for which the metadata generation
    /// run was started.
    owning_project_id: ?[]const u8 = null,

    /// The status of the metadata generation run.
    status: ?MetadataGenerationRunStatus = null,

    /// The type of the metadata generation run.
    @"type": ?MetadataGenerationRunType = null,

    /// The types of the metadata generation run.
    types: ?[]const MetadataGenerationRunType = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .created_by = "createdBy",
        .domain_id = "domainId",
        .id = "id",
        .owning_project_id = "owningProjectId",
        .status = "status",
        .@"type" = "type",
        .types = "types",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartMetadataGenerationRunInput, options: Options) !StartMetadataGenerationRunOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "datazone");

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

fn serializeRequest(alloc: std.mem.Allocator, input: StartMetadataGenerationRunInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/v2/domains/");
    try path_buf.appendSlice(alloc, input.domain_identifier);
    try path_buf.appendSlice(alloc, "/metadata-generation-runs");
    const path = try path_buf.toOwnedSlice(alloc);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"owningProjectIdentifier\":");
    try aws.json.writeValue(@TypeOf(input.owning_project_identifier), input.owning_project_identifier, alloc, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"target\":");
    try aws.json.writeValue(@TypeOf(input.target), input.target, alloc, &body_buf);
    has_prev = true;
    if (input.@"type") |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"type\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.types) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"types\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !StartMetadataGenerationRunOutput {
    var result: StartMetadataGenerationRunOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(StartMetadataGenerationRunOutput, body, alloc);
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
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
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
    if (std.mem.eql(u8, error_code, "UnauthorizedException")) {
        return .{ .arena = arena, .kind = .{ .unauthorized_exception = .{
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
