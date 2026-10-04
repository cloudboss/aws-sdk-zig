const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ApiDestination = @import("api_destination.zig").ApiDestination;

pub const ListApiDestinationsInput = struct {
    /// The ARN of the connection specified for the API destination.
    connection_arn: ?[]const u8 = null,

    /// The maximum number of API destinations to include in the response.
    limit: ?i32 = null,

    /// A name prefix to filter results returned. Only API destinations with a name
    /// that starts
    /// with the prefix are returned.
    name_prefix: ?[]const u8 = null,

    /// The token returned by a previous call, which you can use to retrieve the
    /// next set of results.
    ///
    /// The value of `nextToken` is a unique pagination token for each page. To
    /// retrieve the next page of results, make the call again using
    /// the returned token. Keep all other arguments unchanged.
    ///
    /// Using an expired pagination token results in an `HTTP 400 InvalidToken`
    /// error.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .connection_arn = "ConnectionArn",
        .limit = "Limit",
        .name_prefix = "NamePrefix",
        .next_token = "NextToken",
    };
};

pub const ListApiDestinationsOutput = struct {
    /// An array that includes information about each API
    /// destination.
    api_destinations: ?[]const ApiDestination = null,

    /// A token indicating there are more results available. If there are no more
    /// results, no token is included in the response.
    ///
    /// The value of `nextToken` is a unique pagination token for each page. To
    /// retrieve the next page of results, make the call again using
    /// the returned token. Keep all other arguments unchanged.
    ///
    /// Using an expired pagination token results in an `HTTP 400 InvalidToken`
    /// error.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .api_destinations = "ApiDestinations",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListApiDestinationsInput, options: CallOptions) !ListApiDestinationsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "events", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListApiDestinationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("events", "EventBridge", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSEvents.ListApiDestinations");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListApiDestinationsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListApiDestinationsOutput, body, allocator);
}
