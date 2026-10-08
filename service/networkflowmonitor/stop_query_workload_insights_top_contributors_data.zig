const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const StopQueryWorkloadInsightsTopContributorsDataInput = struct {
    /// The identifier for the query. A query ID is an internally-generated
    /// identifier for a specific query returned from an API call to create a query.
    query_id: []const u8,

    /// The identifier for the scope that includes the resources you want to get
    /// data results for. A scope ID is an internally-generated identifier that
    /// includes all the resources for a specific root account.
    scope_id: []const u8,

    pub const json_field_names = .{
        .query_id = "queryId",
        .scope_id = "scopeId",
    };
};

pub const StopQueryWorkloadInsightsTopContributorsDataOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StopQueryWorkloadInsightsTopContributorsDataInput, options: CallOptions) !StopQueryWorkloadInsightsTopContributorsDataOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "networkflowmonitor", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StopQueryWorkloadInsightsTopContributorsDataInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("networkflowmonitor", "NetworkFlowMonitor", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/workloadInsights/");
    try path_buf.appendSlice(allocator, input.scope_id);
    try path_buf.appendSlice(allocator, "/topContributorsDataQueries/");
    try path_buf.appendSlice(allocator, input.query_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .DELETE;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StopQueryWorkloadInsightsTopContributorsDataOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: StopQueryWorkloadInsightsTopContributorsDataOutput = .{};

    return result;
}
