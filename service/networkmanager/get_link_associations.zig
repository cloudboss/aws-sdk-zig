const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LinkAssociation = @import("link_association.zig").LinkAssociation;

pub const GetLinkAssociationsInput = struct {
    /// The ID of the device.
    device_id: ?[]const u8 = null,

    /// The ID of the global network.
    global_network_id: []const u8,

    /// The ID of the link.
    link_id: ?[]const u8 = null,

    /// The maximum number of results to return.
    max_results: ?i32 = null,

    /// The token for the next page of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .device_id = "DeviceId",
        .global_network_id = "GlobalNetworkId",
        .link_id = "LinkId",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const GetLinkAssociationsOutput = struct {
    /// The link associations.
    link_associations: ?[]const LinkAssociation = null,

    /// The token for the next page of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .link_associations = "LinkAssociations",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetLinkAssociationsInput, options: CallOptions) !GetLinkAssociationsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetLinkAssociationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("networkmanager", "NetworkManager", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/global-networks/");
    try path_buf.appendSlice(allocator, input.global_network_id);
    try path_buf.appendSlice(allocator, "/link-associations");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.device_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "deviceId=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.link_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "linkId=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "maxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "nextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetLinkAssociationsOutput {
    var result: GetLinkAssociationsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetLinkAssociationsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
