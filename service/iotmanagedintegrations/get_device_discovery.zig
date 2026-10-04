const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DiscoveryType = @import("discovery_type.zig").DiscoveryType;
const DeviceDiscoveryStatus = @import("device_discovery_status.zig").DeviceDiscoveryStatus;

pub const GetDeviceDiscoveryInput = struct {
    /// The id of the device discovery job request.
    identifier: []const u8,

    pub const json_field_names = .{
        .identifier = "Identifier",
    };
};

pub const GetDeviceDiscoveryOutput = struct {
    /// The identifier of the account association used for the device discovery.
    account_association_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the device discovery job request.
    arn: []const u8,

    /// The ID tracking the current discovery process for one connector association.
    connector_association_id: ?[]const u8 = null,

    /// The id of the end-user's IoT hub.
    controller_id: ?[]const u8 = null,

    /// The discovery type supporting the type of device to be discovered in the
    /// device discovery job request.
    discovery_type: DiscoveryType,

    /// The timestamp value for the completion time of the device discovery.
    finished_at: ?i64 = null,

    /// The id of the device discovery job request.
    id: []const u8,

    /// The timestamp value for the start time of the device discovery.
    started_at: i64,

    /// The status of the device discovery job request.
    status: DeviceDiscoveryStatus,

    /// A set of key/value pairs that are used to manage the device discovery
    /// request.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .account_association_id = "AccountAssociationId",
        .arn = "Arn",
        .connector_association_id = "ConnectorAssociationId",
        .controller_id = "ControllerId",
        .discovery_type = "DiscoveryType",
        .finished_at = "FinishedAt",
        .id = "Id",
        .started_at = "StartedAt",
        .status = "Status",
        .tags = "Tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDeviceDiscoveryInput, options: CallOptions) !GetDeviceDiscoveryOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetDeviceDiscoveryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.iotmanagedintegrations", "IoT Managed Integrations", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/device-discoveries/");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDeviceDiscoveryOutput {
    const result: GetDeviceDiscoveryOutput = try aws.json.parseJsonObject(
        GetDeviceDiscoveryOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
