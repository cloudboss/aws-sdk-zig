const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MembershipLevel = @import("membership_level.zig").MembershipLevel;
const DeadlinePrincipalType = @import("deadline_principal_type.zig").DeadlinePrincipalType;

pub const AssociateMemberToQueueInput = struct {
    /// The farm ID of the queue to associate with the member.
    farm_id: []const u8,

    /// The Region of the IAM Identity Center instance. If not provided, the service
    /// defaults to the Region of the farm.
    identity_center_region: ?[]const u8 = null,

    /// The member's identity store ID to associate with the queue.
    identity_store_id: []const u8,

    /// The principal's membership level for the associated queue.
    membership_level: MembershipLevel,

    /// The member's principal ID to associate with the queue.
    principal_id: []const u8,

    /// The member's principal type to associate with the queue.
    principal_type: DeadlinePrincipalType,

    /// The ID of the queue to associate to the member.
    queue_id: []const u8,

    pub const json_field_names = .{
        .farm_id = "farmId",
        .identity_center_region = "identityCenterRegion",
        .identity_store_id = "identityStoreId",
        .membership_level = "membershipLevel",
        .principal_id = "principalId",
        .principal_type = "principalType",
        .queue_id = "queueId",
    };
};

pub const AssociateMemberToQueueOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AssociateMemberToQueueInput, options: CallOptions) !AssociateMemberToQueueOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "deadline", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: AssociateMemberToQueueInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("deadline", "deadline", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2023-10-12/farms/");
    try path_buf.appendSlice(allocator, input.farm_id);
    try path_buf.appendSlice(allocator, "/queues/");
    try path_buf.appendSlice(allocator, input.queue_id);
    try path_buf.appendSlice(allocator, "/members/");
    try path_buf.appendSlice(allocator, input.principal_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.identity_center_region) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"identityCenterRegion\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"identityStoreId\":");
    try aws.json.writeValue(@TypeOf(input.identity_store_id), input.identity_store_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"membershipLevel\":");
    try aws.json.writeValue(@TypeOf(input.membership_level), input.membership_level, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"principalType\":");
    try aws.json.writeValue(@TypeOf(input.principal_type), input.principal_type, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AssociateMemberToQueueOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: AssociateMemberToQueueOutput = .{};

    return result;
}
