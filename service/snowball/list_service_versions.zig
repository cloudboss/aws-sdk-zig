const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const DependentService = @import("dependent_service.zig").DependentService;
const ServiceName = @import("service_name.zig").ServiceName;
const ServiceVersion = @import("service_version.zig").ServiceVersion;

pub const ListServiceVersionsInput = struct {
    /// A list of names and versions of dependant services of the requested service.
    dependent_services: ?[]const DependentService = null,

    /// The maximum number of `ListServiceVersions` objects to return.
    max_results: ?i32 = null,

    /// Because HTTP requests are stateless, this is the starting point for the next
    /// list of returned
    /// `ListServiceVersionsRequest` versions.
    next_token: ?[]const u8 = null,

    /// The name of the service for which you're requesting supported versions.
    service_name: ServiceName,

    pub const json_field_names = .{
        .dependent_services = "DependentServices",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .service_name = "ServiceName",
    };
};

pub const ListServiceVersionsOutput = struct {
    /// A list of names and versions of dependant services of the service for which
    /// the system provided supported versions.
    dependent_services: ?[]const DependentService = null,

    /// Because HTTP requests are stateless, this is the starting point of the next
    /// list of returned
    /// `ListServiceVersionsResult` results.
    next_token: ?[]const u8 = null,

    /// The name of the service for which the system provided supported versions.
    service_name: ServiceName,

    /// A list of supported versions.
    service_versions: ?[]const ServiceVersion = null,

    pub const json_field_names = .{
        .dependent_services = "DependentServices",
        .next_token = "NextToken",
        .service_name = "ServiceName",
        .service_versions = "ServiceVersions",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListServiceVersionsInput, options: Options) !ListServiceVersionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "snowball");

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

fn serializeRequest(alloc: std.mem.Allocator, input: ListServiceVersionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("snowball", "Snowball", alloc);

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
    try request.headers.put(alloc, "X-Amz-Target", "AWSIESnowballJobManagementService.ListServiceVersions");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !ListServiceVersionsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListServiceVersionsOutput, body, alloc);
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

    if (std.mem.eql(u8, error_code, "ClusterLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .cluster_limit_exceeded_exception = .{
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
    if (std.mem.eql(u8, error_code, "Ec2RequestFailedException")) {
        return .{ .arena = arena, .kind = .{ .ec_2_request_failed_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidAddressException")) {
        return .{ .arena = arena, .kind = .{ .invalid_address_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidInputCombinationException")) {
        return .{ .arena = arena, .kind = .{ .invalid_input_combination_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidJobStateException")) {
        return .{ .arena = arena, .kind = .{ .invalid_job_state_exception = .{
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
    if (std.mem.eql(u8, error_code, "InvalidResourceException")) {
        return .{ .arena = arena, .kind = .{ .invalid_resource_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KMSRequestFailedException")) {
        return .{ .arena = arena, .kind = .{ .kms_request_failed_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ReturnShippingLabelAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .return_shipping_label_already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedAddressException")) {
        return .{ .arena = arena, .kind = .{ .unsupported_address_exception = .{
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
