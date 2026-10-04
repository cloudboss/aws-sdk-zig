const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResourceType = @import("resource_type.zig").ResourceType;
const LimitsProfile = @import("limits_profile.zig").LimitsProfile;

pub const ListLimitsProfilesInput = struct {
    /// The ID of the Amazon Web Services account that contains the limits profiles.
    account_id: []const u8,

    /// The maximum number of results to return in a single call. If you don't
    /// specify a value, the service uses the default maximum.
    max_results: ?i32 = null,

    /// The token for the next set of results, or null if there are no more results.
    next_token: ?[]const u8 = null,

    /// An optional filter that limits the results to profiles that contain the
    /// specified resource type. If you don't specify a value, the operation returns
    /// all profiles.
    resource_type: ?ResourceType = null,

    pub const json_field_names = .{
        .account_id = "accountId",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .resource_type = "resourceType",
    };
};

pub const ListLimitsProfilesOutput = struct {
    /// The token for the next set of results, or null if there are no more results.
    next_token: ?[]const u8 = null,

    /// A list of limits profiles.
    profiles: ?[]const LimitsProfile = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .profiles = "profiles",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListLimitsProfilesInput, options: CallOptions) !ListLimitsProfilesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "quicksight", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListLimitsProfilesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("quicksight", "QuickSight", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/governance/limits/accounts/");
    try path_buf.appendSlice(allocator, input.account_id);
    try path_buf.appendSlice(allocator, "/profiles");
    const path = try path_buf.toOwnedSlice(allocator);

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
    if (input.resource_type) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "resourceType=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListLimitsProfilesOutput {
    const result: ListLimitsProfilesOutput = try aws.json.parseJsonObject(
        ListLimitsProfilesOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
