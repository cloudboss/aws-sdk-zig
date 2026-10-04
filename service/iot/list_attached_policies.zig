const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Policy = @import("policy.zig").Policy;

pub const ListAttachedPoliciesInput = struct {
    /// The token to retrieve the next set of results.
    marker: ?[]const u8 = null,

    /// The maximum number of results to be returned per request.
    page_size: ?i32 = null,

    /// When true, recursively list attached policies.
    recursive: ?bool = null,

    /// The group or principal for which the policies will be listed. Valid
    /// principals are CertificateArn
    /// (arn:aws:iot:*region*:*accountId*:cert/*certificateId*), thingGroupArn
    /// (arn:aws:iot:*region*:*accountId*:thinggroup/*groupName*) and CognitoId
    /// (*region*:*id*).
    target: []const u8,

    pub const json_field_names = .{
        .marker = "marker",
        .page_size = "pageSize",
        .recursive = "recursive",
        .target = "target",
    };
};

pub const ListAttachedPoliciesOutput = struct {
    /// The token to retrieve the next set of results, or ``null`` if there are no
    /// more
    /// results.
    next_marker: ?[]const u8 = null,

    /// The policies.
    policies: ?[]const Policy = null,

    pub const json_field_names = .{
        .next_marker = "nextMarker",
        .policies = "policies",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListAttachedPoliciesInput, options: CallOptions) !ListAttachedPoliciesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListAttachedPoliciesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/attached-policies/");
    try path_buf.appendSlice(allocator, input.target);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.marker) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "marker=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.page_size) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "pageSize=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.recursive) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "recursive=");
        try query_buf.appendSlice(allocator, if (v) "true" else "false");
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListAttachedPoliciesOutput {
    const result: ListAttachedPoliciesOutput = try aws.json.parseJsonObject(
        ListAttachedPoliciesOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
