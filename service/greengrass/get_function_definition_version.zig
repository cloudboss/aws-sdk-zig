const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const FunctionDefinitionVersion = @import("function_definition_version.zig").FunctionDefinitionVersion;

pub const GetFunctionDefinitionVersionInput = struct {
    /// The ID of the Lambda function definition.
    function_definition_id: []const u8,

    /// The ID of the function definition version. This value maps to the
    /// ''Version'' property of the corresponding ''VersionInformation'' object,
    /// which is returned by ''ListFunctionDefinitionVersions'' requests. If the
    /// version is the last one that was associated with a function definition, the
    /// value also maps to the ''LatestVersion'' property of the corresponding
    /// ''DefinitionInformation'' object.
    function_definition_version_id: []const u8,

    /// The token for the next set of results, or ''null'' if there are no
    /// additional results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .function_definition_id = "FunctionDefinitionId",
        .function_definition_version_id = "FunctionDefinitionVersionId",
        .next_token = "NextToken",
    };
};

pub const GetFunctionDefinitionVersionOutput = struct {
    /// The ARN of the function definition version.
    arn: ?[]const u8 = null,

    /// The time, in milliseconds since the epoch, when the function definition
    /// version was created.
    creation_timestamp: ?[]const u8 = null,

    /// Information on the definition.
    definition: ?FunctionDefinitionVersion = null,

    /// The ID of the function definition version.
    id: ?[]const u8 = null,

    /// The token for the next set of results, or ''null'' if there are no
    /// additional results.
    next_token: ?[]const u8 = null,

    /// The version of the function definition version.
    version: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .creation_timestamp = "CreationTimestamp",
        .definition = "Definition",
        .id = "Id",
        .next_token = "NextToken",
        .version = "Version",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetFunctionDefinitionVersionInput, options: Options) !GetFunctionDefinitionVersionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "greengrass");

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

fn serializeRequest(alloc: std.mem.Allocator, input: GetFunctionDefinitionVersionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("greengrass", "Greengrass", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/greengrass/definition/functions/");
    try path_buf.appendSlice(alloc, input.function_definition_id);
    try path_buf.appendSlice(alloc, "/versions/");
    try path_buf.appendSlice(alloc, input.function_definition_version_id);
    const path = try path_buf.toOwnedSlice(alloc);

    var query_buf: std.ArrayList(u8) = .{};
    var query_has_prev = false;
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "NextToken=");
        try aws.url.appendUrlEncoded(alloc, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(alloc);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    request.query = query;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetFunctionDefinitionVersionOutput {
    var result: GetFunctionDefinitionVersionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetFunctionDefinitionVersionOutput, body, alloc);
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
    if (std.mem.eql(u8, error_code, "InternalServerErrorException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_error_exception = .{
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
