const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SimulationAppEndpointInfo = @import("simulation_app_endpoint_info.zig").SimulationAppEndpointInfo;
const LaunchOverrides = @import("launch_overrides.zig").LaunchOverrides;
const SimulationAppStatus = @import("simulation_app_status.zig").SimulationAppStatus;
const SimulationAppTargetStatus = @import("simulation_app_target_status.zig").SimulationAppTargetStatus;

pub const DescribeAppInput = struct {
    /// The name of the app.
    app: []const u8,

    /// The name of the domain of the app.
    domain: []const u8,

    /// The name of the simulation of the app.
    simulation: []const u8,

    pub const json_field_names = .{
        .app = "App",
        .domain = "Domain",
        .simulation = "Simulation",
    };
};

pub const DescribeAppOutput = struct {
    /// The description of the app.
    description: ?[]const u8 = null,

    /// The name of the domain of the app.
    domain: ?[]const u8 = null,

    /// Information about the network endpoint for the custom app. You can use the
    /// endpoint to connect to the custom app.
    endpoint_info: ?SimulationAppEndpointInfo = null,

    launch_overrides: ?LaunchOverrides = null,

    /// The name of the app.
    name: ?[]const u8 = null,

    /// The name of the simulation of the app.
    simulation: ?[]const u8 = null,

    /// The current lifecycle state of the custom app.
    status: ?SimulationAppStatus = null,

    /// The desired lifecycle state of the custom app.
    target_status: ?SimulationAppTargetStatus = null,

    pub const json_field_names = .{
        .description = "Description",
        .domain = "Domain",
        .endpoint_info = "EndpointInfo",
        .launch_overrides = "LaunchOverrides",
        .name = "Name",
        .simulation = "Simulation",
        .status = "Status",
        .target_status = "TargetStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeAppInput, options: CallOptions) !DescribeAppOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeAppInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("simspaceweaver", "SimSpaceWeaver", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/describeapp";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "app=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.app);
    query_has_prev = true;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "domain=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.domain);
    query_has_prev = true;
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeAppOutput {
    var result: DescribeAppOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeAppOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
