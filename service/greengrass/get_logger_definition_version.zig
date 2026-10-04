const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LoggerDefinitionVersion = @import("logger_definition_version.zig").LoggerDefinitionVersion;

pub const GetLoggerDefinitionVersionInput = struct {
    /// The ID of the logger definition.
    logger_definition_id: []const u8,

    /// The ID of the logger definition version. This value maps to the ''Version''
    /// property of the corresponding ''VersionInformation'' object, which is
    /// returned by ''ListLoggerDefinitionVersions'' requests. If the version is the
    /// last one that was associated with a logger definition, the value also maps
    /// to the ''LatestVersion'' property of the corresponding
    /// ''DefinitionInformation'' object.
    logger_definition_version_id: []const u8,

    /// The token for the next set of results, or ''null'' if there are no
    /// additional results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .logger_definition_id = "LoggerDefinitionId",
        .logger_definition_version_id = "LoggerDefinitionVersionId",
        .next_token = "NextToken",
    };
};

pub const GetLoggerDefinitionVersionOutput = struct {
    /// The ARN of the logger definition version.
    arn: ?[]const u8 = null,

    /// The time, in milliseconds since the epoch, when the logger definition
    /// version was created.
    creation_timestamp: ?[]const u8 = null,

    /// Information about the logger definition version.
    definition: ?LoggerDefinitionVersion = null,

    /// The ID of the logger definition version.
    id: ?[]const u8 = null,

    /// The version of the logger definition version.
    version: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .creation_timestamp = "CreationTimestamp",
        .definition = "Definition",
        .id = "Id",
        .version = "Version",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetLoggerDefinitionVersionInput, options: CallOptions) !GetLoggerDefinitionVersionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "greengrass", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: GetLoggerDefinitionVersionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("greengrass", "Greengrass", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/greengrass/definition/loggers/");
    try path_buf.appendSlice(allocator, input.logger_definition_id);
    try path_buf.appendSlice(allocator, "/versions/");
    try path_buf.appendSlice(allocator, input.logger_definition_version_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "NextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetLoggerDefinitionVersionOutput {
    const result: GetLoggerDefinitionVersionOutput = try aws.json.parseJsonObject(
        GetLoggerDefinitionVersionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
