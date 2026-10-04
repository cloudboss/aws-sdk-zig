const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CapabilityReport = @import("capability_report.zig").CapabilityReport;

pub const GetManagedThingCapabilitiesInput = struct {
    /// The id of the device.
    identifier: []const u8,

    pub const json_field_names = .{
        .identifier = "Identifier",
    };
};

pub const GetManagedThingCapabilitiesOutput = struct {
    /// The capabilities of the device such as light bulb.
    capabilities: ?[]const u8 = null,

    /// A report of the capabilities for the managed thing.
    capability_report: ?CapabilityReport = null,

    /// The id of the device.
    managed_thing_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .capabilities = "Capabilities",
        .capability_report = "CapabilityReport",
        .managed_thing_id = "ManagedThingId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetManagedThingCapabilitiesInput, options: CallOptions) !GetManagedThingCapabilitiesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iotmanagedintegrations", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetManagedThingCapabilitiesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.iotmanagedintegrations", "IoT Managed Integrations", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/managed-things-capabilities/");
    try path_buf.appendSlice(allocator, input.identifier);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetManagedThingCapabilitiesOutput {
    var result: GetManagedThingCapabilitiesOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetManagedThingCapabilitiesOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
