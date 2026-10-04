const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BehaviorCriteriaType = @import("behavior_criteria_type.zig").BehaviorCriteriaType;
const VerificationState = @import("verification_state.zig").VerificationState;
const ActiveViolation = @import("active_violation.zig").ActiveViolation;

pub const ListActiveViolationsInput = struct {
    /// The criteria for a behavior.
    behavior_criteria_type: ?BehaviorCriteriaType = null,

    /// A list of all suppressed alerts.
    list_suppressed_alerts: ?bool = null,

    /// The maximum number of results to return at one time.
    max_results: ?i32 = null,

    /// The token for the next set of results.
    next_token: ?[]const u8 = null,

    /// The name of the Device Defender security profile for which violations are
    /// listed.
    security_profile_name: ?[]const u8 = null,

    /// The name of the thing whose active violations are listed.
    thing_name: ?[]const u8 = null,

    /// The verification state of the violation (detect alarm).
    verification_state: ?VerificationState = null,

    pub const json_field_names = .{
        .behavior_criteria_type = "behaviorCriteriaType",
        .list_suppressed_alerts = "listSuppressedAlerts",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .security_profile_name = "securityProfileName",
        .thing_name = "thingName",
        .verification_state = "verificationState",
    };
};

pub const ListActiveViolationsOutput = struct {
    /// The list of active violations.
    active_violations: ?[]const ActiveViolation = null,

    /// A token that can be used to retrieve the next set of results,
    /// or `null` if there are no additional results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .active_violations = "activeViolations",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListActiveViolationsInput, options: CallOptions) !ListActiveViolationsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iot", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListActiveViolationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/active-violations";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.behavior_criteria_type) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "behaviorCriteriaType=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    if (input.list_suppressed_alerts) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "listSuppressedAlerts=");
        try query_buf.appendSlice(allocator, if (v) "true" else "false");
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
    if (input.security_profile_name) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "securityProfileName=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.thing_name) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "thingName=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.verification_state) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "verificationState=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListActiveViolationsOutput {
    const result: ListActiveViolationsOutput = try aws.json.parseJsonObject(
        ListActiveViolationsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
