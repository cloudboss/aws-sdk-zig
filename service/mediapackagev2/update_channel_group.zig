const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const UpdateChannelGroupInput = struct {
    /// The name that describes the channel group. The name is the primary
    /// identifier for the channel group, and must be unique for your account in the
    /// AWS Region.
    channel_group_name: []const u8,

    /// Any descriptive information that you want to add to the channel group for
    /// future identification purposes.
    description: ?[]const u8 = null,

    /// The expected current Entity Tag (ETag) for the resource. If the specified
    /// ETag does not match the resource's current entity tag, the update request
    /// will be rejected.
    e_tag: ?[]const u8 = null,

    pub const json_field_names = .{
        .channel_group_name = "ChannelGroupName",
        .description = "Description",
        .e_tag = "ETag",
    };
};

pub const UpdateChannelGroupOutput = struct {
    /// The Amazon Resource Name (ARN) associated with the resource.
    arn: []const u8,

    /// The name that describes the channel group. The name is the primary
    /// identifier for the channel group, and must be unique for your account in the
    /// AWS Region.
    channel_group_name: []const u8,

    /// The date and time the channel group was created.
    created_at: i64,

    /// The description for your channel group.
    description: ?[]const u8 = null,

    /// The output domain where the source stream is sent. Integrate the domain with
    /// a downstream CDN (such as Amazon CloudFront) or playback device.
    egress_domain: []const u8,

    /// The current Entity Tag (ETag) associated with this resource. The entity tag
    /// can be used to safely make concurrent updates to the resource.
    e_tag: ?[]const u8 = null,

    /// The date and time the channel group was modified.
    modified_at: i64,

    /// The comma-separated list of tag key:value pairs assigned to the channel
    /// group.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .channel_group_name = "ChannelGroupName",
        .created_at = "CreatedAt",
        .description = "Description",
        .egress_domain = "EgressDomain",
        .e_tag = "ETag",
        .modified_at = "ModifiedAt",
        .tags = "Tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateChannelGroupInput, options: CallOptions) !UpdateChannelGroupOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateChannelGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mediapackagev2", "MediaPackageV2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/channelGroup/");
    try path_buf.appendSlice(allocator, input.channel_group_name);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");
    if (input.e_tag) |v| {
        try request.headers.put(allocator, "x-amzn-update-if-match", v);
    }

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateChannelGroupOutput {
    const result: UpdateChannelGroupOutput = try aws.json.parseJsonObject(
        UpdateChannelGroupOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
