const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const CreateChannelGroupInput = struct {
    /// The name that describes the channel group. The name is the primary
    /// identifier for the channel group, and must be unique for your account in the
    /// AWS Region. You can't use spaces in the name. You can't change the name
    /// after you create the channel group.
    channel_group_name: []const u8,

    /// A unique, case-sensitive token that you provide to ensure the idempotency of
    /// the request.
    client_token: ?[]const u8 = null,

    /// Enter any descriptive text that helps you to identify the channel group.
    description: ?[]const u8 = null,

    /// A comma-separated list of tag key:value pairs that you define. For example:
    ///
    /// `"Key1": "Value1",`
    ///
    /// `"Key2": "Value2"`
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .channel_group_name = "ChannelGroupName",
        .client_token = "ClientToken",
        .description = "Description",
        .tags = "Tags",
    };
};

pub const CreateChannelGroupOutput = struct {
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

    /// The output domain where the source stream should be sent. Integrate the
    /// egress domain with a downstream CDN (such as Amazon CloudFront) or playback
    /// device.
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateChannelGroupInput, options: CallOptions) !CreateChannelGroupOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateChannelGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mediapackagev2", "MediaPackageV2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/channelGroup";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ChannelGroupName\":");
    try aws.json.writeValue(@TypeOf(input.channel_group_name), input.channel_group_name, allocator, &body_buf);
    has_prev = true;
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
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
    if (input.client_token) |v| {
        try request.headers.put(allocator, "x-amzn-client-token", v);
    }

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateChannelGroupOutput {
    const result: CreateChannelGroupOutput = try aws.json.parseJsonObject(
        CreateChannelGroupOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
