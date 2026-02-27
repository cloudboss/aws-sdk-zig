const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ServiceEndpointType = @import("service_endpoint_type.zig").ServiceEndpointType;
const ErrorResponse = @import("error_response.zig").ErrorResponse;
const LambdaEndpointConfig = @import("lambda_endpoint_config.zig").LambdaEndpointConfig;
const ServiceState = @import("service_state.zig").ServiceState;
const UrlEndpointConfig = @import("url_endpoint_config.zig").UrlEndpointConfig;

pub const GetServiceInput = struct {
    /// The ID of the application.
    application_identifier: []const u8,

    /// The ID of the environment.
    environment_identifier: []const u8,

    /// The ID of the service.
    service_identifier: []const u8,

    pub const json_field_names = .{
        .application_identifier = "ApplicationIdentifier",
        .environment_identifier = "EnvironmentIdentifier",
        .service_identifier = "ServiceIdentifier",
    };
};

pub const GetServiceOutput = struct {
    /// The ID of the application.
    application_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the service.
    arn: ?[]const u8 = null,

    /// The Amazon Web Services account ID of the service creator.
    created_by_account_id: ?[]const u8 = null,

    /// The timestamp of when the service is created.
    created_time: ?i64 = null,

    /// The description of the service.
    description: ?[]const u8 = null,

    /// The endpoint type of the service.
    endpoint_type: ?ServiceEndpointType = null,

    /// The unique identifier of the environment.
    environment_id: ?[]const u8 = null,

    /// Any error associated with the service resource.
    @"error": ?ErrorResponse = null,

    /// The configuration for the Lambda endpoint type.
    ///
    /// The **Arn** is the Amazon Resource Name (ARN) of the Lambda function
    /// associated with this service.
    lambda_endpoint: ?LambdaEndpointConfig = null,

    /// A timestamp that indicates when the service was last updated.
    last_updated_time: ?i64 = null,

    /// The name of the service.
    name: ?[]const u8 = null,

    /// The Amazon Web Services account ID of the service owner.
    owner_account_id: ?[]const u8 = null,

    /// The unique identifier of the service.
    service_id: ?[]const u8 = null,

    /// The current state of the service.
    state: ?ServiceState = null,

    /// The tags assigned to the service. A tag is a label that you assign to an
    /// Amazon Web Services resource. Each tag consists of a key-value pair.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The configuration for the URL endpoint type.
    ///
    /// The **Url** isthe URL of the endpoint type.
    ///
    /// The **HealthUrl** is the health check URL of the endpoint
    /// type.
    url_endpoint: ?UrlEndpointConfig = null,

    /// The ID of the virtual private cloud (VPC).
    vpc_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .application_id = "ApplicationId",
        .arn = "Arn",
        .created_by_account_id = "CreatedByAccountId",
        .created_time = "CreatedTime",
        .description = "Description",
        .endpoint_type = "EndpointType",
        .environment_id = "EnvironmentId",
        .@"error" = "Error",
        .lambda_endpoint = "LambdaEndpoint",
        .last_updated_time = "LastUpdatedTime",
        .name = "Name",
        .owner_account_id = "OwnerAccountId",
        .service_id = "ServiceId",
        .state = "State",
        .tags = "Tags",
        .url_endpoint = "UrlEndpoint",
        .vpc_id = "VpcId",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetServiceInput, options: Options) !GetServiceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "migrationhubrefactorspaces");

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

fn serializeRequest(alloc: std.mem.Allocator, input: GetServiceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("migrationhubrefactorspaces", "Migration Hub Refactor Spaces", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/environments/");
    try path_buf.appendSlice(alloc, input.environment_identifier);
    try path_buf.appendSlice(alloc, "/applications/");
    try path_buf.appendSlice(alloc, input.application_identifier);
    try path_buf.appendSlice(alloc, "/services/");
    try path_buf.appendSlice(alloc, input.service_identifier);
    const path = try path_buf.toOwnedSlice(alloc);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetServiceOutput {
    var result: GetServiceOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetServiceOutput, body, alloc);
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
    if (std.mem.eql(u8, error_code, "InvalidResourcePolicyException")) {
        return .{ .arena = arena, .kind = .{ .invalid_resource_policy_exception = .{
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
