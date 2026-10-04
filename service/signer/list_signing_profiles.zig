const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SigningProfileStatus = @import("signing_profile_status.zig").SigningProfileStatus;
const SigningProfile = @import("signing_profile.zig").SigningProfile;

pub const ListSigningProfilesInput = struct {
    /// Designates whether to include profiles with the status of
    /// `CANCELED`.
    include_canceled: ?bool = null,

    /// The maximum number of profiles to be returned.
    max_results: ?i32 = null,

    /// Value for specifying the next set of paginated results to return. After you
    /// receive a
    /// response with truncated results, use this parameter in a subsequent request.
    /// Set it to
    /// the value of `nextToken` from the response that you just received.
    next_token: ?[]const u8 = null,

    /// Filters results to return only signing jobs initiated for a specified
    /// signing
    /// platform.
    platform_id: ?[]const u8 = null,

    /// Filters results to return only signing jobs with statuses in the specified
    /// list.
    statuses: ?[]const SigningProfileStatus = null,

    pub const json_field_names = .{
        .include_canceled = "includeCanceled",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .platform_id = "platformId",
        .statuses = "statuses",
    };
};

pub const ListSigningProfilesOutput = struct {
    /// Value for specifying the next set of paginated results to return.
    next_token: ?[]const u8 = null,

    /// A list of profiles that are available in the AWS account. This includes
    /// profiles with
    /// the status of `CANCELED` if the `includeCanceled` parameter is set
    /// to `true`.
    profiles: ?[]const SigningProfile = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .profiles = "profiles",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListSigningProfilesInput, options: CallOptions) !ListSigningProfilesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "signer", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListSigningProfilesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("signer", "signer", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/signing-profiles";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.include_canceled) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "includeCanceled=");
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
    if (input.platform_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "platformId=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.statuses) |v| {
        for (v) |item| {
            if (query_has_prev) try query_buf.appendSlice(allocator, "&");
            try query_buf.appendSlice(allocator, "statuses=");
            try aws.url.appendUrlEncoded(allocator, &query_buf, item.wireName());
            query_has_prev = true;
        }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListSigningProfilesOutput {
    var result: ListSigningProfilesOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListSigningProfilesOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
