const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CdnAuthConfiguration = @import("cdn_auth_configuration.zig").CdnAuthConfiguration;

pub const PutOriginEndpointPolicyInput = struct {
    /// The settings for using authorization headers between the MediaPackage
    /// endpoint and your CDN.
    ///
    /// For information about CDN authorization, see [CDN authorization in Elemental
    /// MediaPackage](https://docs.aws.amazon.com/mediapackage/latest/userguide/cdn-auth.html) in the MediaPackage user guide.
    cdn_auth_configuration: ?CdnAuthConfiguration = null,

    /// The name that describes the channel group. The name is the primary
    /// identifier for the channel group, and must be unique for your account in the
    /// AWS Region.
    channel_group_name: []const u8,

    /// The name that describes the channel. The name is the primary identifier for
    /// the channel, and must be unique for your account in the AWS Region and
    /// channel group.
    channel_name: []const u8,

    /// The name that describes the origin endpoint. The name is the primary
    /// identifier for the origin endpoint, and and must be unique for your account
    /// in the AWS Region and channel.
    origin_endpoint_name: []const u8,

    /// The policy to attach to the specified origin endpoint.
    policy: []const u8,

    pub const json_field_names = .{
        .cdn_auth_configuration = "CdnAuthConfiguration",
        .channel_group_name = "ChannelGroupName",
        .channel_name = "ChannelName",
        .origin_endpoint_name = "OriginEndpointName",
        .policy = "Policy",
    };
};

pub const PutOriginEndpointPolicyOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutOriginEndpointPolicyInput, options: CallOptions) !PutOriginEndpointPolicyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "mediapackagev2", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutOriginEndpointPolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mediapackagev2", "MediaPackageV2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/channelGroup/");
    try path_buf.appendSlice(allocator, input.channel_group_name);
    try path_buf.appendSlice(allocator, "/channel/");
    try path_buf.appendSlice(allocator, input.channel_name);
    try path_buf.appendSlice(allocator, "/originEndpoint/");
    try path_buf.appendSlice(allocator, input.origin_endpoint_name);
    try path_buf.appendSlice(allocator, "/policy");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.cdn_auth_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"CdnAuthConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Policy\":");
    try aws.json.writeValue(@TypeOf(input.policy), input.policy, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutOriginEndpointPolicyOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: PutOriginEndpointPolicyOutput = .{};

    return result;
}
