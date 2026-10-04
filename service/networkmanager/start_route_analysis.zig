const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RouteAnalysisEndpointOptionsSpecification = @import("route_analysis_endpoint_options_specification.zig").RouteAnalysisEndpointOptionsSpecification;
const RouteAnalysis = @import("route_analysis.zig").RouteAnalysis;

pub const StartRouteAnalysisInput = struct {
    /// The destination.
    destination: RouteAnalysisEndpointOptionsSpecification,

    /// The ID of the global network.
    global_network_id: []const u8,

    /// Indicates whether to analyze the return path. The default is `false`.
    include_return_path: ?bool = null,

    /// The source from which traffic originates.
    source: RouteAnalysisEndpointOptionsSpecification,

    /// Indicates whether to include the location of middlebox appliances in the
    /// route analysis.
    /// The default is `false`.
    use_middleboxes: ?bool = null,

    pub const json_field_names = .{
        .destination = "Destination",
        .global_network_id = "GlobalNetworkId",
        .include_return_path = "IncludeReturnPath",
        .source = "Source",
        .use_middleboxes = "UseMiddleboxes",
    };
};

pub const StartRouteAnalysisOutput = struct {
    /// The route analysis.
    route_analysis: ?RouteAnalysis = null,

    pub const json_field_names = .{
        .route_analysis = "RouteAnalysis",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartRouteAnalysisInput, options: CallOptions) !StartRouteAnalysisOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartRouteAnalysisInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("networkmanager", "NetworkManager", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/global-networks/");
    try path_buf.appendSlice(allocator, input.global_network_id);
    try path_buf.appendSlice(allocator, "/route-analyses");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Destination\":");
    try aws.json.writeValue(@TypeOf(input.destination), input.destination, allocator, &body_buf);
    has_prev = true;
    if (input.include_return_path) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"IncludeReturnPath\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Source\":");
    try aws.json.writeValue(@TypeOf(input.source), input.source, allocator, &body_buf);
    has_prev = true;
    if (input.use_middleboxes) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"UseMiddleboxes\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartRouteAnalysisOutput {
    const result: StartRouteAnalysisOutput = try aws.json.parseJsonObject(
        StartRouteAnalysisOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
