const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MemberConfiguration = @import("member_configuration.zig").MemberConfiguration;

pub const CreateMemberInput = struct {
    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the operation. An idempotent operation completes no more than
    /// one time. This identifier is required only if you make a service request
    /// directly using an HTTP client. It is generated automatically if you use an
    /// Amazon Web Services SDK or the CLI.
    client_request_token: []const u8,

    /// The unique identifier of the invitation that is sent to the member to join
    /// the network.
    invitation_id: []const u8,

    /// Member configuration parameters.
    member_configuration: MemberConfiguration,

    /// The unique identifier of the network in which the member is created.
    network_id: []const u8,

    pub const json_field_names = .{
        .client_request_token = "ClientRequestToken",
        .invitation_id = "InvitationId",
        .member_configuration = "MemberConfiguration",
        .network_id = "NetworkId",
    };
};

pub const CreateMemberOutput = struct {
    /// The unique identifier of the member.
    member_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .member_id = "MemberId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateMemberInput, options: CallOptions) !CreateMemberOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "managedblockchain", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateMemberInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("managedblockchain", "ManagedBlockchain", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/networks/");
    try path_buf.appendSlice(allocator, input.network_id);
    try path_buf.appendSlice(allocator, "/members");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ClientRequestToken\":");
    try aws.json.writeValue(@TypeOf(input.client_request_token), input.client_request_token, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"InvitationId\":");
    try aws.json.writeValue(@TypeOf(input.invitation_id), input.invitation_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"MemberConfiguration\":");
    try aws.json.writeValue(@TypeOf(input.member_configuration), input.member_configuration, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateMemberOutput {
    const result: CreateMemberOutput = try aws.json.parseJsonObject(
        CreateMemberOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
