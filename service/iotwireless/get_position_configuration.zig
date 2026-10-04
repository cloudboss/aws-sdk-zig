const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PositionResourceType = @import("position_resource_type.zig").PositionResourceType;
const PositionSolverDetails = @import("position_solver_details.zig").PositionSolverDetails;

pub const GetPositionConfigurationInput = struct {
    /// Resource identifier used in a position configuration.
    resource_identifier: []const u8,

    /// Resource type of the resource for which position configuration is retrieved.
    resource_type: PositionResourceType,

    pub const json_field_names = .{
        .resource_identifier = "ResourceIdentifier",
        .resource_type = "ResourceType",
    };
};

pub const GetPositionConfigurationOutput = struct {
    /// The position data destination that describes the AWS IoT rule that processes
    /// the
    /// device's position data for use by AWS IoT Core for LoRaWAN.
    destination: ?[]const u8 = null,

    /// The wrapper for the solver configuration details object.
    solvers: ?PositionSolverDetails = null,

    pub const json_field_names = .{
        .destination = "Destination",
        .solvers = "Solvers",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetPositionConfigurationInput, options: CallOptions) !GetPositionConfigurationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetPositionConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.iotwireless", "IoT Wireless", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/position-configurations/");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetPositionConfigurationOutput {
    var result: GetPositionConfigurationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetPositionConfigurationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
