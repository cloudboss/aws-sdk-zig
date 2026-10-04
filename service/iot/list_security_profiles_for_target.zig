const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SecurityProfileTargetMapping = @import("security_profile_target_mapping.zig").SecurityProfileTargetMapping;

pub const ListSecurityProfilesForTargetInput = struct {
    /// The maximum number of results to return at one time.
    max_results: ?i32 = null,

    /// The token for the next set of results.
    next_token: ?[]const u8 = null,

    /// If true, return child groups too.
    recursive: ?bool = null,

    /// The ARN of the target (thing group) whose attached security profiles you
    /// want to get.
    security_profile_target_arn: []const u8,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .next_token = "nextToken",
        .recursive = "recursive",
        .security_profile_target_arn = "securityProfileTargetArn",
    };
};

pub const ListSecurityProfilesForTargetOutput = struct {
    /// A token that can be used to retrieve the next set of results, or `null` if
    /// there are no
    /// additional results.
    next_token: ?[]const u8 = null,

    /// A list of security profiles and their associated targets.
    security_profile_target_mappings: ?[]const SecurityProfileTargetMapping = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .security_profile_target_mappings = "securityProfileTargetMappings",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListSecurityProfilesForTargetInput, options: CallOptions) !ListSecurityProfilesForTargetOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListSecurityProfilesForTargetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/security-profiles-for-target";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
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
    if (input.recursive) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "recursive=");
        try query_buf.appendSlice(allocator, if (v) "true" else "false");
        query_has_prev = true;
    }
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "securityProfileTargetArn=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.security_profile_target_arn);
    query_has_prev = true;
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListSecurityProfilesForTargetOutput {
    var result: ListSecurityProfilesForTargetOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListSecurityProfilesForTargetOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
