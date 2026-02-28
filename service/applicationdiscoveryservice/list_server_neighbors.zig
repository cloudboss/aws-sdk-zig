const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const NeighborConnectionDetail = @import("neighbor_connection_detail.zig").NeighborConnectionDetail;

pub const ListServerNeighborsInput = struct {
    /// Configuration ID of the server for which neighbors are being listed.
    configuration_id: []const u8,

    /// Maximum number of results to return in a single page of output.
    max_results: ?i32 = null,

    /// List of configuration IDs to test for one-hop-away.
    neighbor_configuration_ids: ?[]const []const u8 = null,

    /// Token to retrieve the next set of results. For example, if you previously
    /// specified 100
    /// IDs for `ListServerNeighborsRequest$neighborConfigurationIds` but set
    /// `ListServerNeighborsRequest$maxResults` to 10, you received a set of 10
    /// results
    /// along with a token. Use that token in this query to get the next set of 10.
    next_token: ?[]const u8 = null,

    /// Flag to indicate if port and protocol information is needed as part of the
    /// response.
    port_information_needed: ?bool = null,

    pub const json_field_names = .{
        .configuration_id = "configurationId",
        .max_results = "maxResults",
        .neighbor_configuration_ids = "neighborConfigurationIds",
        .next_token = "nextToken",
        .port_information_needed = "portInformationNeeded",
    };
};

pub const ListServerNeighborsOutput = struct {
    /// Count of distinct servers that are one hop away from the given server.
    known_dependency_count: ?i64 = null,

    /// List of distinct servers that are one hop away from the given server.
    neighbors: ?[]const NeighborConnectionDetail = null,

    /// Token to retrieve the next set of results. For example, if you specified 100
    /// IDs for
    /// `ListServerNeighborsRequest$neighborConfigurationIds` but set
    /// `ListServerNeighborsRequest$maxResults` to 10, you received a set of 10
    /// results
    /// along with this token. Use this token in the next query to retrieve the next
    /// set of
    /// 10.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .known_dependency_count = "knownDependencyCount",
        .neighbors = "neighbors",
        .next_token = "nextToken",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListServerNeighborsInput, options: Options) !ListServerNeighborsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "applicationdiscoveryservice");

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

fn serializeRequest(alloc: std.mem.Allocator, input: ListServerNeighborsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("applicationdiscoveryservice", "Application Discovery Service", alloc);

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
    try request.headers.put(alloc, "X-Amz-Target", "AWSPoseidonService_V2015_11_01.ListServerNeighbors");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !ListServerNeighborsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListServerNeighborsOutput, body, alloc);
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

    if (std.mem.eql(u8, error_code, "AuthorizationErrorException")) {
        return .{ .arena = arena, .kind = .{ .authorization_error_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictErrorException")) {
        return .{ .arena = arena, .kind = .{ .conflict_error_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "HomeRegionNotSetException")) {
        return .{ .arena = arena, .kind = .{ .home_region_not_set_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterException")) {
        return .{ .arena = arena, .kind = .{ .invalid_parameter_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterValueException")) {
        return .{ .arena = arena, .kind = .{ .invalid_parameter_value_exception = .{
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
    if (std.mem.eql(u8, error_code, "OperationNotPermittedException")) {
        return .{ .arena = arena, .kind = .{ .operation_not_permitted_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUseException")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use_exception = .{
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
    if (std.mem.eql(u8, error_code, "ServerInternalErrorException")) {
        return .{ .arena = arena, .kind = .{ .server_internal_error_exception = .{
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
