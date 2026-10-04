const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PositionResourceType = @import("position_resource_type.zig").PositionResourceType;
const Accuracy = @import("accuracy.zig").Accuracy;
const PositionSolverProvider = @import("position_solver_provider.zig").PositionSolverProvider;
const PositionSolverType = @import("position_solver_type.zig").PositionSolverType;

pub const GetPositionInput = struct {
    /// Resource identifier used to retrieve the position information.
    resource_identifier: []const u8,

    /// Resource type of the resource for which position information is retrieved.
    resource_type: PositionResourceType,

    pub const json_field_names = .{
        .resource_identifier = "ResourceIdentifier",
        .resource_type = "ResourceType",
    };
};

pub const GetPositionOutput = struct {
    /// The accuracy of the estimated position in meters. An empty value indicates
    /// that no
    /// position data is available. A value of ‘0.0’ value indicates that position
    /// data is
    /// available. This data corresponds to the position information that you
    /// specified instead
    /// of the position computed by solver.
    accuracy: ?Accuracy = null,

    /// The position information of the resource.
    position: ?[]const f32 = null,

    /// The vendor of the positioning solver.
    solver_provider: ?PositionSolverProvider = null,

    /// The type of solver used to identify the position of the resource.
    solver_type: ?PositionSolverType = null,

    /// The version of the positioning solver.
    solver_version: ?[]const u8 = null,

    /// The timestamp at which the device's position was determined.
    timestamp: ?[]const u8 = null,

    pub const json_field_names = .{
        .accuracy = "Accuracy",
        .position = "Position",
        .solver_provider = "SolverProvider",
        .solver_type = "SolverType",
        .solver_version = "SolverVersion",
        .timestamp = "Timestamp",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetPositionInput, options: CallOptions) !GetPositionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iotwireless", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetPositionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.iotwireless", "IoT Wireless", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/positions/");
    try path_buf.appendSlice(allocator, input.resource_identifier);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "resourceType=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.resource_type.wireName());
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetPositionOutput {
    const result: GetPositionOutput = try aws.json.parseJsonObject(
        GetPositionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
