const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Bandwidth = @import("bandwidth.zig").Bandwidth;
const Tag = @import("tag.zig").Tag;
const Link = @import("link.zig").Link;

pub const CreateLinkInput = struct {
    /// The upload speed and download speed in Mbps.
    bandwidth: Bandwidth,

    /// A description of the link.
    ///
    /// Constraints: Maximum length of 256 characters.
    description: ?[]const u8 = null,

    /// The ID of the global network.
    global_network_id: []const u8,

    /// The provider of the link.
    ///
    /// Constraints: Maximum length of 128 characters. Cannot include the following
    /// characters: | \ ^
    provider: ?[]const u8 = null,

    /// The ID of the site.
    site_id: []const u8,

    /// The tags to apply to the resource during creation.
    tags: ?[]const Tag = null,

    /// The type of the link.
    ///
    /// Constraints: Maximum length of 128 characters. Cannot include the following
    /// characters: | \ ^
    type: ?[]const u8 = null,

    pub const json_field_names = .{
        .bandwidth = "Bandwidth",
        .description = "Description",
        .global_network_id = "GlobalNetworkId",
        .provider = "Provider",
        .site_id = "SiteId",
        .tags = "Tags",
        .type = "Type",
    };
};

pub const CreateLinkOutput = struct {
    /// Information about the link.
    link: ?Link = null,

    pub const json_field_names = .{
        .link = "Link",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateLinkInput, options: CallOptions) !CreateLinkOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateLinkInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("networkmanager", "NetworkManager", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/global-networks/");
    try path_buf.appendSlice(allocator, input.global_network_id);
    try path_buf.appendSlice(allocator, "/links");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Bandwidth\":");
    try aws.json.writeValue(@TypeOf(input.bandwidth), input.bandwidth, allocator, &body_buf);
    has_prev = true;
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.provider) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Provider\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"SiteId\":");
    try aws.json.writeValue(@TypeOf(input.site_id), input.site_id, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Type\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateLinkOutput {
    const result: CreateLinkOutput = try aws.json.parseJsonObject(
        CreateLinkOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
