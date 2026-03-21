const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const Credentials = @import("credentials.zig").Credentials;

pub const GetManagedEndpointSessionCredentialsInput = struct {
    /// The client idempotency token of the job run request.
    client_token: ?[]const u8 = null,

    /// Type of the token requested. Currently supported and default value of this
    /// field is
    /// “TOKEN.”
    credential_type: []const u8,

    /// Duration in seconds for which the session token is valid. The default
    /// duration is 15
    /// minutes and the maximum is 12 hours.
    duration_in_seconds: ?i32 = null,

    /// The ARN of the managed endpoint for which the request is submitted.
    endpoint_identifier: []const u8,

    /// The IAM Execution Role ARN that will be used by the job run.
    execution_role_arn: []const u8,

    /// String identifier used to separate sections of the execution logs uploaded
    /// to S3.
    log_context: ?[]const u8 = null,

    /// The ARN of the Virtual Cluster which the Managed Endpoint belongs to.
    virtual_cluster_identifier: []const u8,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .credential_type = "credentialType",
        .duration_in_seconds = "durationInSeconds",
        .endpoint_identifier = "endpointIdentifier",
        .execution_role_arn = "executionRoleArn",
        .log_context = "logContext",
        .virtual_cluster_identifier = "virtualClusterIdentifier",
    };
};

pub const GetManagedEndpointSessionCredentialsOutput = struct {
    /// The structure containing the session credentials.
    credentials: ?Credentials = null,

    /// The date and time when the session token will expire.
    expires_at: ?i64 = null,

    /// The identifier of the session token returned.
    id: ?[]const u8 = null,

    pub const json_field_names = .{
        .credentials = "credentials",
        .expires_at = "expiresAt",
        .id = "id",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetManagedEndpointSessionCredentialsInput, options: CallOptions) !GetManagedEndpointSessionCredentialsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "emr-containers");

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetManagedEndpointSessionCredentialsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("emr-containers", "EMR containers", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/virtualclusters/");
    try path_buf.appendSlice(allocator, input.virtual_cluster_identifier);
    try path_buf.appendSlice(allocator, "/endpoints/");
    try path_buf.appendSlice(allocator, input.endpoint_identifier);
    try path_buf.appendSlice(allocator, "/credentials");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"credentialType\":");
    try aws.json.writeValue(@TypeOf(input.credential_type), input.credential_type, allocator, &body_buf);
    has_prev = true;
    if (input.duration_in_seconds) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"durationInSeconds\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"executionRoleArn\":");
    try aws.json.writeValue(@TypeOf(input.execution_role_arn), input.execution_role_arn, allocator, &body_buf);
    has_prev = true;
    if (input.log_context) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"logContext\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetManagedEndpointSessionCredentialsOutput {
    var result: GetManagedEndpointSessionCredentialsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetManagedEndpointSessionCredentialsOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "EKSRequestThrottledException")) {
        return .{ .arena = arena, .kind = .{ .eks_request_throttled_exception = .{
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
    if (std.mem.eql(u8, error_code, "RequestThrottledException")) {
        return .{ .arena = arena, .kind = .{ .request_throttled_exception = .{
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
