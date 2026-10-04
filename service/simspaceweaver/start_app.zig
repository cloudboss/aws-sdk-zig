const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LaunchOverrides = @import("launch_overrides.zig").LaunchOverrides;

pub const StartAppInput = struct {
    /// A value that you provide to ensure that repeated calls to this
    /// API operation using the same parameters complete only once. A `ClientToken`
    /// is also known as an
    /// *idempotency token*. A `ClientToken` expires after 24 hours.
    client_token: ?[]const u8 = null,

    /// The description of the app.
    description: ?[]const u8 = null,

    /// The name of the domain of the app.
    domain: []const u8,

    launch_overrides: ?LaunchOverrides = null,

    /// The name of the app.
    name: []const u8,

    /// The name of the simulation of the app.
    simulation: []const u8,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .description = "Description",
        .domain = "Domain",
        .launch_overrides = "LaunchOverrides",
        .name = "Name",
        .simulation = "Simulation",
    };
};

pub const StartAppOutput = struct {
    /// The name of the domain of the app.
    domain: ?[]const u8 = null,

    /// The name of the app.
    name: ?[]const u8 = null,

    /// The name of the simulation of the app.
    simulation: ?[]const u8 = null,

    pub const json_field_names = .{
        .domain = "Domain",
        .name = "Name",
        .simulation = "Simulation",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartAppInput, options: CallOptions) !StartAppOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartAppInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("simspaceweaver", "SimSpaceWeaver", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/startapp";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ClientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Domain\":");
    try aws.json.writeValue(@TypeOf(input.domain), input.domain, allocator, &body_buf);
    has_prev = true;
    if (input.launch_overrides) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"LaunchOverrides\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Simulation\":");
    try aws.json.writeValue(@TypeOf(input.simulation), input.simulation, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartAppOutput {
    var result: StartAppOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(StartAppOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
