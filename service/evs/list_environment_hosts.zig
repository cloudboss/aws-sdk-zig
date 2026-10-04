const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Host = @import("host.zig").Host;

pub const ListEnvironmentHostsInput = struct {
    /// A unique ID for the environment.
    environment_id: []const u8,

    /// The maximum number of results to return. If you specify `MaxResults` in the
    /// request, the response includes information up to the limit specified.
    max_results: ?i32 = null,

    /// A unique pagination token for each page. If `nextToken` is returned, there
    /// are more results available. Make the call again using the returned token
    /// with all other arguments unchanged to retrieve the next page. Each
    /// pagination token expires after 24 hours. Using an expired pagination token
    /// will return an *HTTP 400 InvalidToken* error.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .environment_id = "environmentId",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListEnvironmentHostsOutput = struct {
    /// A list of hosts in the environment.
    environment_hosts: ?[]const Host = null,

    /// A unique pagination token for next page results. Make the call again using
    /// this token to retrieve the next page.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .environment_hosts = "environmentHosts",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListEnvironmentHostsInput, options: CallOptions) !ListEnvironmentHostsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "evs", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListEnvironmentHostsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("evs", "evs", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonElasticVMwareService.ListEnvironmentHosts");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListEnvironmentHostsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListEnvironmentHostsOutput, body, allocator);
}
