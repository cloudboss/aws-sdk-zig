const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ChannelMembershipType = @import("channel_membership_type.zig").ChannelMembershipType;
const BatchChannelMemberships = @import("batch_channel_memberships.zig").BatchChannelMemberships;
const BatchCreateChannelMembershipError = @import("batch_create_channel_membership_error.zig").BatchCreateChannelMembershipError;

pub const BatchCreateChannelMembershipInput = struct {
    /// The ARN of the channel to which you're adding users or bots.
    channel_arn: []const u8,

    /// The ARN of the `AppInstanceUser` or `AppInstanceBot`
    /// that makes the API call.
    chime_bearer: []const u8,

    /// The ARNs of the members you want to add to the channel. Only
    /// `AppInstanceUsers` and
    /// `AppInstanceBots` can be added as a channel member.
    member_arns: []const []const u8,

    /// The ID of the SubChannel in the request.
    ///
    /// Only required when creating membership in a SubChannel for a moderator in an
    /// elastic channel.
    sub_channel_id: ?[]const u8 = null,

    /// The membership type of a user, `DEFAULT` or `HIDDEN`. Default
    /// members are always returned as part of `ListChannelMemberships`. Hidden
    /// members
    /// are only returned if the type filter in `ListChannelMemberships` equals
    /// `HIDDEN`. Otherwise hidden members are not returned. This is only supported
    /// by moderators.
    type: ?ChannelMembershipType = null,

    pub const json_field_names = .{
        .channel_arn = "ChannelArn",
        .chime_bearer = "ChimeBearer",
        .member_arns = "MemberArns",
        .sub_channel_id = "SubChannelId",
        .type = "Type",
    };
};

pub const BatchCreateChannelMembershipOutput = struct {
    /// The list of channel memberships in the response.
    batch_channel_memberships: ?BatchChannelMemberships = null,

    /// If the action fails for one or more of the memberships in the request, a
    /// list of the
    /// memberships is returned, along with error codes and error messages.
    errors: ?[]const BatchCreateChannelMembershipError = null,

    pub const json_field_names = .{
        .batch_channel_memberships = "BatchChannelMemberships",
        .errors = "Errors",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchCreateChannelMembershipInput, options: CallOptions) !BatchCreateChannelMembershipOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "chime", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchCreateChannelMembershipInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("messaging-chime", "Chime SDK Messaging", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/channels/");
    try path_buf.appendSlice(allocator, input.channel_arn);
    try path_buf.appendSlice(allocator, "/memberships");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    try query_buf.appendSlice(allocator, "operation=batch-create");
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"MemberArns\":");
    try aws.json.writeValue(@TypeOf(input.member_arns), input.member_arns, allocator, &body_buf);
    has_prev = true;
    if (input.sub_channel_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SubChannelId\":");
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
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");
    try request.headers.put(allocator, "x-amz-chime-bearer", input.chime_bearer);

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchCreateChannelMembershipOutput {
    const result: BatchCreateChannelMembershipOutput = try aws.json.parseJsonObject(
        BatchCreateChannelMembershipOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
