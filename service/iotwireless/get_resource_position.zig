const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PositionResourceType = @import("position_resource_type.zig").PositionResourceType;

pub const GetResourcePositionInput = struct {
    /// The identifier of the resource for which position information is retrieved.
    /// It can be
    /// the wireless device ID or the wireless gateway ID, depending on the resource
    /// type.
    resource_identifier: []const u8,

    /// The type of resource for which position information is retrieved, which can
    /// be a
    /// wireless device or a wireless gateway.
    resource_type: PositionResourceType,

    pub const json_field_names = .{
        .resource_identifier = "ResourceIdentifier",
        .resource_type = "ResourceType",
    };
};

pub const GetResourcePositionOutput = struct {
    /// The position information of the resource, displayed as a JSON payload. The
    /// payload
    /// uses the GeoJSON format, which a format that's used to encode geographic
    /// data
    /// structures. For more information, see [GeoJSON](https://geojson.org/).
    geo_json_payload: ?[]const u8 = null,

    pub const json_field_names = .{
        .geo_json_payload = "GeoJsonPayload",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetResourcePositionInput, options: CallOptions) !GetResourcePositionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetResourcePositionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.iotwireless", "IoT Wireless", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/resource-positions/");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetResourcePositionOutput {
    var result: GetResourcePositionOutput = .{};
    errdefer {
        if (result.geo_json_payload) |value| allocator.free(value);
    }
    if (body.len > 0) {
        result.geo_json_payload = try allocator.dupe(u8, body);
    }
    _ = status;
    _ = headers;

    return result;
}
