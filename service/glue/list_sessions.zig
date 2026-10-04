const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Session = @import("session.zig").Session;

pub const ListSessionsInput = struct {
    /// The maximum number of results.
    max_results: ?i32 = null,

    /// The token for the next set of results, or null if there are no more result.
    next_token: ?[]const u8 = null,

    /// The origin of the request.
    request_origin: ?[]const u8 = null,

    /// Tags belonging to the session.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .request_origin = "RequestOrigin",
        .tags = "Tags",
    };
};

pub const ListSessionsOutput = struct {
    /// Returns the ID of the session.
    ids: ?[]const []const u8 = null,

    /// The token for the next set of results, or null if there are no more result.
    next_token: ?[]const u8 = null,

    /// Returns the session object.
    sessions: ?[]const Session = null,

    pub const json_field_names = .{
        .ids = "Ids",
        .next_token = "NextToken",
        .sessions = "Sessions",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListSessionsInput, options: CallOptions) !ListSessionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "glue", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListSessionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("glue", "Glue", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.ListSessions");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListSessionsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListSessionsOutput, body, allocator);
}
