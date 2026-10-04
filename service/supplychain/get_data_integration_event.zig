const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DataIntegrationEvent = @import("data_integration_event.zig").DataIntegrationEvent;

pub const GetDataIntegrationEventInput = struct {
    /// The unique event identifier.
    event_id: []const u8,

    /// The Amazon Web Services Supply Chain instance identifier.
    instance_id: []const u8,

    pub const json_field_names = .{
        .event_id = "eventId",
        .instance_id = "instanceId",
    };
};

pub const GetDataIntegrationEventOutput = struct {
    /// The details of the DataIntegrationEvent returned.
    event: ?DataIntegrationEvent = null,

    pub const json_field_names = .{
        .event = "event",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDataIntegrationEventInput, options: CallOptions) !GetDataIntegrationEventOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "scn", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetDataIntegrationEventInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("scn", "SupplyChain", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/api-data/data-integration/instance/");
    try path_buf.appendSlice(allocator, input.instance_id);
    try path_buf.appendSlice(allocator, "/data-integration-events/");
    try path_buf.appendSlice(allocator, input.event_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDataIntegrationEventOutput {
    const result: GetDataIntegrationEventOutput = try aws.json.parseJsonObject(
        GetDataIntegrationEventOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
