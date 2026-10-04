const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RouteAnalysis = @import("route_analysis.zig").RouteAnalysis;

pub const GetRouteAnalysisInput = struct {
    /// The ID of the global network.
    global_network_id: []const u8,

    /// The ID of the route analysis.
    route_analysis_id: []const u8,

    pub const json_field_names = .{
        .global_network_id = "GlobalNetworkId",
        .route_analysis_id = "RouteAnalysisId",
    };
};

pub const GetRouteAnalysisOutput = struct {
    /// The route analysis.
    route_analysis: ?RouteAnalysis = null,

    pub const json_field_names = .{
        .route_analysis = "RouteAnalysis",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetRouteAnalysisInput, options: CallOptions) !GetRouteAnalysisOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "networkmanager", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetRouteAnalysisInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("networkmanager", "NetworkManager", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/global-networks/");
    try path_buf.appendSlice(allocator, input.global_network_id);
    try path_buf.appendSlice(allocator, "/route-analyses/");
    try path_buf.appendSlice(allocator, input.route_analysis_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetRouteAnalysisOutput {
    const result: GetRouteAnalysisOutput = try aws.json.parseJsonObject(
        GetRouteAnalysisOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
