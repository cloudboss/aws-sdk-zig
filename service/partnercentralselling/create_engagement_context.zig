const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const EngagementContextPayload = @import("engagement_context_payload.zig").EngagementContextPayload;
const EngagementContextType = @import("engagement_context_type.zig").EngagementContextType;

pub const CreateEngagementContextInput = struct {
    /// Specifies the catalog associated with the engagement context request. This
    /// field takes a string value from a predefined list: `AWS` or `Sandbox`. The
    /// catalog determines which environment the engagement context is created in.
    /// Use `AWS` to create contexts in the production environment, and `Sandbox`
    /// for testing in secure, isolated environments.
    catalog: []const u8,

    /// A unique, case-sensitive identifier provided by the client to ensure that
    /// the request is handled exactly once. This token helps prevent duplicate
    /// context creations and must not exceed sixty-four alphanumeric characters.
    /// Use a UUID or other unique string to ensure idempotency.
    client_token: []const u8,

    /// The unique identifier of the `Engagement` for which the context is being
    /// created. This parameter ensures the context is associated with the correct
    /// engagement and provides the necessary linkage between the engagement and its
    /// contextual information.
    engagement_identifier: []const u8,

    payload: EngagementContextPayload,

    /// Specifies the type of context being created for the engagement. This field
    /// determines the structure and content of the context payload. Valid values
    /// include `CustomerProject` for customer project-related contexts. The type
    /// field ensures that the context is properly categorized and processed
    /// according to its intended purpose.
    @"type": EngagementContextType,

    pub const json_field_names = .{
        .catalog = "Catalog",
        .client_token = "ClientToken",
        .engagement_identifier = "EngagementIdentifier",
        .payload = "Payload",
        .@"type" = "Type",
    };
};

pub const CreateEngagementContextOutput = struct {
    /// The unique identifier assigned to the newly created engagement context. This
    /// ID can be used to reference the specific context within the engagement for
    /// future operations.
    context_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the engagement to which the context was
    /// added. This globally unique identifier can be used for cross-service
    /// references and IAM policies.
    engagement_arn: ?[]const u8 = null,

    /// The unique identifier of the engagement to which the context was added. This
    /// ID confirms the successful association of the context with the specified
    /// engagement.
    engagement_id: ?[]const u8 = null,

    /// The timestamp indicating when the engagement was last modified as a result
    /// of adding the context, in ISO 8601 format (UTC). Example:
    /// "2023-05-01T20:37:46Z".
    engagement_last_modified_at: ?i64 = null,

    pub const json_field_names = .{
        .context_id = "ContextId",
        .engagement_arn = "EngagementArn",
        .engagement_id = "EngagementId",
        .engagement_last_modified_at = "EngagementLastModifiedAt",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateEngagementContextInput, options: Options) !CreateEngagementContextOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "partnercentralselling");

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

fn serializeRequest(alloc: std.mem.Allocator, input: CreateEngagementContextInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("partnercentralselling", "PartnerCentral Selling", alloc);

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
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(alloc, "X-Amz-Target", "AWSPartnerCentralSelling.CreateEngagementContext");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateEngagementContextOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateEngagementContextOutput, body, alloc);
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
