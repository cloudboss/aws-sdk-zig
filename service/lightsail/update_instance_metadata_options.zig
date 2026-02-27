const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const HttpEndpoint = @import("http_endpoint.zig").HttpEndpoint;
const HttpProtocolIpv6 = @import("http_protocol_ipv_6.zig").HttpProtocolIpv6;
const HttpTokens = @import("http_tokens.zig").HttpTokens;
const Operation = @import("operation.zig").Operation;

pub const UpdateInstanceMetadataOptionsInput = struct {
    /// Enables or disables the HTTP metadata endpoint on your instances. If this
    /// parameter is not
    /// specified, the existing state is maintained.
    ///
    /// If you specify a value of `disabled`, you cannot access your instance
    /// metadata.
    http_endpoint: ?HttpEndpoint = null,

    /// Enables or disables the IPv6 endpoint for the instance metadata service.
    /// This setting
    /// applies only when the HTTP metadata endpoint is enabled.
    ///
    /// This parameter is available only for instances in the Europe (Stockholm)
    /// Amazon Web Services Region (`eu-north-1`).
    http_protocol_ipv_6: ?HttpProtocolIpv6 = null,

    /// The desired HTTP PUT response hop limit for instance metadata requests. A
    /// larger number
    /// means that the instance metadata requests can travel farther. If no
    /// parameter is specified,
    /// the existing state is maintained.
    http_put_response_hop_limit: ?i32 = null,

    /// The state of token usage for your instance metadata requests. If the
    /// parameter is not
    /// specified in the request, the default state is `optional`.
    ///
    /// If the state is `optional`, you can choose whether to retrieve instance
    /// metadata with a signed token header on your request. If you retrieve the IAM
    /// role credentials
    /// without a token, the version 1.0 role credentials are returned. If you
    /// retrieve the IAM role
    /// credentials by using a valid signed token, the version 2.0 role credentials
    /// are
    /// returned.
    ///
    /// If the state is `required`, you must send a signed token header with all
    /// instance metadata retrieval requests. In this state, retrieving the IAM role
    /// credential always
    /// returns the version 2.0 credentials. The version 1.0 credentials are not
    /// available.
    http_tokens: ?HttpTokens = null,

    /// The name of the instance for which to update metadata parameters.
    instance_name: []const u8,

    pub const json_field_names = .{
        .http_endpoint = "httpEndpoint",
        .http_protocol_ipv_6 = "httpProtocolIpv6",
        .http_put_response_hop_limit = "httpPutResponseHopLimit",
        .http_tokens = "httpTokens",
        .instance_name = "instanceName",
    };
};

pub const UpdateInstanceMetadataOptionsOutput = struct {
    /// An array of objects that describe the result of the action, such as the
    /// status of the
    /// request, the timestamp of the request, and the resources affected by the
    /// request.
    operation: ?Operation = null,

    pub const json_field_names = .{
        .operation = "operation",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateInstanceMetadataOptionsInput, options: Options) !UpdateInstanceMetadataOptionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "lightsail");

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

fn serializeRequest(alloc: std.mem.Allocator, input: UpdateInstanceMetadataOptionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lightsail", "Lightsail", alloc);

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
    try request.headers.put(alloc, "X-Amz-Target", "Lightsail_20161128.UpdateInstanceMetadataOptions");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !UpdateInstanceMetadataOptionsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateInstanceMetadataOptionsOutput, body, alloc);
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
    if (std.mem.eql(u8, error_code, "AccountSetupInProgressException")) {
        return .{ .arena = arena, .kind = .{ .account_setup_in_progress_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidInputException")) {
        return .{ .arena = arena, .kind = .{ .invalid_input_exception = .{
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
    if (std.mem.eql(u8, error_code, "OperationFailureException")) {
        return .{ .arena = arena, .kind = .{ .operation_failure_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RegionSetupInProgressException")) {
        return .{ .arena = arena, .kind = .{ .region_setup_in_progress_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceException")) {
        return .{ .arena = arena, .kind = .{ .service_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnauthenticatedException")) {
        return .{ .arena = arena, .kind = .{ .unauthenticated_exception = .{
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
