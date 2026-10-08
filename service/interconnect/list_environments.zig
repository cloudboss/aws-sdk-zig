const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Provider = @import("provider.zig").Provider;
const Environment = @import("environment.zig").Environment;

pub const ListEnvironmentsInput = struct {
    /// Filter results to only include Environment objects that connect to a given
    /// location distiguisher.
    location: ?[]const u8 = null,

    /// The max number of list results in a single paginated response.
    max_results: ?i32 = null,

    /// A pagination token from a previous paginated response indicating you wish to
    /// get the next page of results.
    next_token: ?[]const u8 = null,

    /// Filter results to only include Environment objects that connect to the
    /// Provider.
    provider: ?Provider = null,

    pub const json_field_names = .{
        .location = "location",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .provider = "provider",
    };
};

pub const ListEnvironmentsOutput = struct {
    /// The list of matching Environment objects.
    environments: ?[]const Environment = null,

    /// A pagination token for use in subsequent calls to fetch the next page of
    /// results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .environments = "environments",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListEnvironmentsInput, options: CallOptions) !ListEnvironmentsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "interconnect", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListEnvironmentsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("interconnect", "Interconnect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "Interconnect.ListEnvironments");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListEnvironmentsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListEnvironmentsOutput, body, allocator);
}
