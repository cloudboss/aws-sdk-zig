const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SimulationAppMetadata = @import("simulation_app_metadata.zig").SimulationAppMetadata;

pub const ListAppsInput = struct {
    /// The name of the domain that you want to list apps for.
    domain: ?[]const u8 = null,

    /// The maximum number of apps to list.
    max_results: ?i32 = null,

    /// If SimSpace Weaver returns `nextToken`, then there are more results
    /// available.
    /// The value of `nextToken` is a unique pagination token for each page. To
    /// retrieve the next page,
    /// call the operation again using the returned token. Keep all other arguments
    /// unchanged. If no results remain,
    /// then `nextToken` is set to `null`. Each pagination token expires after 24
    /// hours.
    /// If you provide a token that isn't valid, then you receive an *HTTP 400
    /// ValidationException* error.
    next_token: ?[]const u8 = null,

    /// The name of the simulation that you want to list apps for.
    simulation: []const u8,

    pub const json_field_names = .{
        .domain = "Domain",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .simulation = "Simulation",
    };
};

pub const ListAppsOutput = struct {
    /// The list of apps for the given simulation and domain.
    apps: ?[]const SimulationAppMetadata = null,

    /// If SimSpace Weaver returns `nextToken`, then there are more results
    /// available.
    /// The value of `nextToken` is a unique pagination token for each page. To
    /// retrieve the next page,
    /// call the operation again using the returned token. Keep all other arguments
    /// unchanged. If no results remain,
    /// then `nextToken` is set to `null`. Each pagination token expires after 24
    /// hours.
    /// If you provide a token that isn't valid, then you receive an *HTTP 400
    /// ValidationException* error.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .apps = "Apps",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListAppsInput, options: CallOptions) !ListAppsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "simspaceweaver", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListAppsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("simspaceweaver", "SimSpaceWeaver", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/listapps";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.domain) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "domain=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "maxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "nextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "simulation=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.simulation);
    query_has_prev = true;
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListAppsOutput {
    var result: ListAppsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListAppsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
