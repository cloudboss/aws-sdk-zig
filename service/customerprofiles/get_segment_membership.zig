const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ProfileQueryFailures = @import("profile_query_failures.zig").ProfileQueryFailures;
const ProfileQueryResult = @import("profile_query_result.zig").ProfileQueryResult;

pub const GetSegmentMembershipInput = struct {
    /// The unique name of the domain.
    domain_name: []const u8,

    /// The list of profile IDs to query for.
    profile_ids: []const []const u8,

    /// The Id of the wanted segment. Needs to be a valid, and existing segment Id.
    segment_definition_name: []const u8,

    pub const json_field_names = .{
        .domain_name = "DomainName",
        .profile_ids = "ProfileIds",
        .segment_definition_name = "SegmentDefinitionName",
    };
};

pub const GetSegmentMembershipOutput = struct {
    /// An array of maps where each contains a response per profile failed for the
    /// request.
    failures: ?[]const ProfileQueryFailures = null,

    /// The timestamp indicating when the segment membership was last computed or
    /// updated.
    last_computed_at: ?i64 = null,

    /// An array of maps where each contains a response per profile requested.
    profiles: ?[]const ProfileQueryResult = null,

    /// The unique name of the segment definition.
    segment_definition_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .failures = "Failures",
        .last_computed_at = "LastComputedAt",
        .profiles = "Profiles",
        .segment_definition_name = "SegmentDefinitionName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetSegmentMembershipInput, options: CallOptions) !GetSegmentMembershipOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "profile", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetSegmentMembershipInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("profile", "Customer Profiles", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/domains/");
    try path_buf.appendSlice(allocator, input.domain_name);
    try path_buf.appendSlice(allocator, "/segments/");
    try path_buf.appendSlice(allocator, input.segment_definition_name);
    try path_buf.appendSlice(allocator, "/membership");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ProfileIds\":");
    try aws.json.writeValue(@TypeOf(input.profile_ids), input.profile_ids, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetSegmentMembershipOutput {
    var result: GetSegmentMembershipOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetSegmentMembershipOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
