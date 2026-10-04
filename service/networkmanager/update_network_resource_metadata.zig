const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const UpdateNetworkResourceMetadataInput = struct {
    /// The ID of the global network.
    global_network_id: []const u8,

    /// The resource metadata.
    metadata: []const aws.map.StringMapEntry,

    /// The ARN of the resource.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .global_network_id = "GlobalNetworkId",
        .metadata = "Metadata",
        .resource_arn = "ResourceArn",
    };
};

pub const UpdateNetworkResourceMetadataOutput = struct {
    /// The updated resource metadata.
    metadata: ?[]const aws.map.StringMapEntry = null,

    /// The ARN of the resource.
    resource_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .metadata = "Metadata",
        .resource_arn = "ResourceArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateNetworkResourceMetadataInput, options: CallOptions) !UpdateNetworkResourceMetadataOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateNetworkResourceMetadataInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("networkmanager", "NetworkManager", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/global-networks/");
    try path_buf.appendSlice(allocator, input.global_network_id);
    try path_buf.appendSlice(allocator, "/network-resources/");
    try path_buf.appendSlice(allocator, input.resource_arn);
    try path_buf.appendSlice(allocator, "/metadata");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Metadata\":");
    try aws.json.writeValue(@TypeOf(input.metadata), input.metadata, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateNetworkResourceMetadataOutput {
    var result: UpdateNetworkResourceMetadataOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateNetworkResourceMetadataOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
