const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const PatchOperation = @import("patch_operation.zig").PatchOperation;
const ApiKeySourceType = @import("api_key_source_type.zig").ApiKeySourceType;
const ApiStatus = @import("api_status.zig").ApiStatus;
const EndpointAccessMode = @import("endpoint_access_mode.zig").EndpointAccessMode;
const EndpointConfiguration = @import("endpoint_configuration.zig").EndpointConfiguration;
const SecurityPolicy = @import("security_policy.zig").SecurityPolicy;

pub const UpdateRestApiInput = struct {
    /// For more information about supported patch operations, see [Patch
    /// Operations](https://docs.aws.amazon.com/apigateway/latest/api/patch-operations.html).
    patch_operations: ?[]const PatchOperation = null,

    /// The string identifier of the associated RestApi.
    rest_api_id: []const u8,

    pub const json_field_names = .{
        .patch_operations = "patchOperations",
        .rest_api_id = "restApiId",
    };
};

pub const UpdateRestApiOutput = struct {
    /// The source of the API key for metering requests according to a usage plan.
    /// Valid values
    /// are: >`HEADER` to read the API key from the `X-API-Key` header of a
    /// request. `AUTHORIZER` to read the API key from the `UsageIdentifierKey`
    /// from a custom authorizer.
    api_key_source: ?ApiKeySourceType = null,

    /// The ApiStatus of the RestApi.
    api_status: ?ApiStatus = null,

    /// The status message of the RestApi. When the status message is `UPDATING` you
    /// can still invoke it.
    api_status_message: ?[]const u8 = null,

    /// The list of binary media types supported by the RestApi. By default, the
    /// RestApi supports only UTF-8-encoded text payloads.
    binary_media_types: ?[]const []const u8 = null,

    /// The timestamp when the API was created.
    created_date: ?i64 = null,

    /// The API's description.
    description: ?[]const u8 = null,

    /// Specifies whether clients can invoke your API by using the default
    /// `execute-api` endpoint.
    /// By default, clients can invoke your API with the default
    /// `https://{api_id}.execute-api.{region}.amazonaws.com` endpoint. To require
    /// that clients use a
    /// custom domain name to invoke your API, disable the default endpoint.
    disable_execute_api_endpoint: bool = false,

    /// The endpoint access mode of the RestApi.
    endpoint_access_mode: ?EndpointAccessMode = null,

    /// The endpoint configuration of this RestApi showing the endpoint types and IP
    /// address types of the API.
    endpoint_configuration: ?EndpointConfiguration = null,

    /// The API's identifier. This identifier is unique across all of your APIs in
    /// API Gateway.
    id: ?[]const u8 = null,

    /// A nullable integer that is used to enable compression (with non-negative
    /// between 0 and 10485760 (10M) bytes, inclusive) or disable compression (with
    /// a null value) on an API. When compression is enabled, compression or
    /// decompression is not applied on the payload if the payload size is smaller
    /// than this value. Setting it to zero allows compression for any payload size.
    minimum_compression_size: ?i32 = null,

    /// The API's name.
    name: ?[]const u8 = null,

    /// A stringified JSON policy document that applies to this RestApi regardless
    /// of the caller and Method configuration.
    policy: ?[]const u8 = null,

    /// The API's root resource ID.
    root_resource_id: ?[]const u8 = null,

    /// The Transport Layer Security (TLS) version + cipher suite for this RestApi.
    security_policy: ?SecurityPolicy = null,

    /// The collection of tags. Each tag element is associated with a given
    /// resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// A version identifier for the API.
    version: ?[]const u8 = null,

    /// The warning messages reported when `failonwarnings` is turned on during API
    /// import.
    warnings: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .api_key_source = "apiKeySource",
        .api_status = "apiStatus",
        .api_status_message = "apiStatusMessage",
        .binary_media_types = "binaryMediaTypes",
        .created_date = "createdDate",
        .description = "description",
        .disable_execute_api_endpoint = "disableExecuteApiEndpoint",
        .endpoint_access_mode = "endpointAccessMode",
        .endpoint_configuration = "endpointConfiguration",
        .id = "id",
        .minimum_compression_size = "minimumCompressionSize",
        .name = "name",
        .policy = "policy",
        .root_resource_id = "rootResourceId",
        .security_policy = "securityPolicy",
        .tags = "tags",
        .version = "version",
        .warnings = "warnings",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateRestApiInput, options: Options) !UpdateRestApiOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "apigateway");

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

fn serializeRequest(alloc: std.mem.Allocator, input: UpdateRestApiInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("apigateway", "API Gateway", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/restapis/");
    try path_buf.appendSlice(alloc, input.rest_api_id);
    const path = try path_buf.toOwnedSlice(alloc);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (input.patch_operations) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"patchOperations\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(alloc, "}");
    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .PATCH;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !UpdateRestApiOutput {
    var result: UpdateRestApiOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateRestApiOutput, body, alloc);
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

    if (std.mem.eql(u8, error_code, "BadRequestException")) {
        return .{ .arena = arena, .kind = .{ .bad_request_exception = .{
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
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotFoundException")) {
        return .{ .arena = arena, .kind = .{ .not_found_exception = .{
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
    if (std.mem.eql(u8, error_code, "TooManyRequestsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_requests_exception = .{
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

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
