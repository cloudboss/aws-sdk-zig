const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MembershipLevel = @import("membership_level.zig").MembershipLevel;
const DeadlinePrincipalType = @import("deadline_principal_type.zig").DeadlinePrincipalType;

pub const AssociateMemberToFleetInput = struct {
    /// The farm ID of the fleet to associate with the member.
    farm_id: []const u8,

    /// The ID of the fleet to associate with a member.
    fleet_id: []const u8,

    /// The member's identity store ID to associate with the fleet.
    identity_store_id: []const u8,

    /// The principal's membership level for the associated fleet.
    membership_level: MembershipLevel,

    /// The member's principal ID to associate with a fleet.
    principal_id: []const u8,

    /// The member's principal type to associate with the fleet.
    principal_type: DeadlinePrincipalType,

    pub const json_field_names = .{
        .farm_id = "farmId",
        .fleet_id = "fleetId",
        .identity_store_id = "identityStoreId",
        .membership_level = "membershipLevel",
        .principal_id = "principalId",
        .principal_type = "principalType",
    };
};

pub const AssociateMemberToFleetOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AssociateMemberToFleetInput, options: CallOptions) !AssociateMemberToFleetOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: AssociateMemberToFleetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("deadline", "deadline", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2023-10-12/farms/");
    try path_buf.appendSlice(allocator, input.farm_id);
    try path_buf.appendSlice(allocator, "/fleets/");
    try path_buf.appendSlice(allocator, input.fleet_id);
    try path_buf.appendSlice(allocator, "/members/");
    try path_buf.appendSlice(allocator, input.principal_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AssociateMemberToFleetOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: AssociateMemberToFleetOutput = .{};

    return result;
}
