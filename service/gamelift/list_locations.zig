const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LocationFilter = @import("location_filter.zig").LocationFilter;
const LocationModel = @import("location_model.zig").LocationModel;

pub const ListLocationsInput = struct {
    /// Filters the list for `AWS` or `CUSTOM` locations. Use this
    /// parameter to narrow down results to only Amazon Web Services-managed
    /// locations (Amazon EC2 or container) or
    /// only your custom locations (such as an Amazon GameLift Servers Anywhere
    /// fleet).
    filters: ?[]const LocationFilter = null,

    /// The maximum number of results to return. Use this parameter with `NextToken`
    /// to get results as a set of sequential pages.
    limit: ?i32 = null,

    /// A token that indicates the start of the next sequential page of results. Use
    /// the token that is returned with a previous call to this operation. To start
    /// at the beginning of the result set, do not specify a value.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .filters = "Filters",
        .limit = "Limit",
        .next_token = "NextToken",
    };
};

pub const ListLocationsOutput = struct {
    /// A collection of locations, including both Amazon Web Services and custom
    /// locations. Each location
    /// includes a name and ping beacon information that can be used to measure
    /// network latency
    /// between player devices and the location.
    locations: ?[]const LocationModel = null,

    /// A token that indicates where to resume retrieving results on the next call
    /// to this operation. If no token is returned, these results represent the end
    /// of the list.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .locations = "Locations",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListLocationsInput, options: CallOptions) !ListLocationsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "gamelift", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListLocationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("gamelift", "GameLift", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "GameLift.ListLocations");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListLocationsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListLocationsOutput, body, allocator);
}
