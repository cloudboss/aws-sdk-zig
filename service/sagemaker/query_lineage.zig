const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const errors = @import("errors.zig");
const ServiceError = errors.ServiceError;
const Direction = @import("direction.zig").Direction;
const QueryFilters = @import("query_filters.zig").QueryFilters;
const Edge = @import("edge.zig").Edge;
const Vertex = @import("vertex.zig").Vertex;

pub const QueryLineageInput = struct {
    /// Associations between lineage entities have a direction. This parameter
    /// determines the direction from the StartArn(s) that the query traverses.
    direction: ?Direction = null,

    /// A set of filtering parameters that allow you to specify which entities
    /// should be returned.
    ///
    /// * Properties - Key-value pairs to match on the lineage entities' properties.
    /// * LineageTypes - A set of lineage entity types to match on. For example:
    ///   `TrialComponent`, `Artifact`, or `Context`.
    /// * CreatedBefore - Filter entities created before this date.
    /// * ModifiedBefore - Filter entities modified before this date.
    /// * ModifiedAfter - Filter entities modified after this date.
    filters: ?QueryFilters = null,

    /// Setting this value to `True` retrieves not only the entities of interest but
    /// also the
    /// [Associations](https://docs.aws.amazon.com/sagemaker/latest/dg/lineage-tracking-entities.html) and lineage entities on the path. Set to `False` to only return lineage entities that match your query.
    include_edges: ?bool = null,

    /// The maximum depth in lineage relationships from the `StartArns` that are
    /// traversed. Depth is a measure of the number of `Associations` from the
    /// `StartArn` entity to the matched results.
    max_depth: ?i32 = null,

    /// Limits the number of vertices in the results. Use the `NextToken` in a
    /// response to to retrieve the next page of results.
    max_results: ?i32 = null,

    /// Limits the number of vertices in the request. Use the `NextToken` in a
    /// response to to retrieve the next page of results.
    next_token: ?[]const u8 = null,

    /// A list of resource Amazon Resource Name (ARN) that represent the starting
    /// point for your lineage query.
    start_arns: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .direction = "Direction",
        .filters = "Filters",
        .include_edges = "IncludeEdges",
        .max_depth = "MaxDepth",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .start_arns = "StartArns",
    };
};

pub const QueryLineageOutput = struct {
    /// A list of edges that connect vertices in the response.
    edges: ?[]const Edge = null,

    /// Limits the number of vertices in the response. Use the `NextToken` in a
    /// response to to retrieve the next page of results.
    next_token: ?[]const u8 = null,

    /// A list of vertices connected to the start entity(ies) in the lineage graph.
    vertices: ?[]const Vertex = null,

    pub const json_field_names = .{
        .edges = "Edges",
        .next_token = "NextToken",
        .vertices = "Vertices",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: QueryLineageInput, options: CallOptions) !QueryLineageOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sagemaker", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch return error.OutOfMemory;
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: QueryLineageInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.sagemaker", "SageMaker", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.QueryLineage");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !QueryLineageOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(QueryLineageOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.findScalarLast(u8, type_str, '#')) |idx| {
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

    if (std.mem.eql(u8, error_code, "ConflictException")) {
        const parsed_error: ?errors.ConflictException = aws.json.parseJsonObject(errors.ConflictException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .conflict_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceInUse")) {
        const parsed_error: ?errors.ResourceInUse = aws.json.parseJsonObject(errors.ResourceInUse, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_in_use = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceLimitExceeded")) {
        const parsed_error: ?errors.ResourceLimitExceeded = aws.json.parseJsonObject(errors.ResourceLimitExceeded, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_limit_exceeded = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFound")) {
        const parsed_error: ?errors.ResourceNotFound = aws.json.parseJsonObject(errors.ResourceNotFound, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_not_found = typed_error } };
        }
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
