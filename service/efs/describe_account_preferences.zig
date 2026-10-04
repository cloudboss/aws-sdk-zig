const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResourceIdPreference = @import("resource_id_preference.zig").ResourceIdPreference;

pub const DescribeAccountPreferencesInput = struct {
    /// (Optional) When retrieving account preferences,
    /// you can optionally specify the `MaxItems` parameter to limit the number of
    /// objects returned in a response.
    /// The default value is 100.
    max_results: ?i32 = null,

    /// (Optional) You can use `NextToken` in a subsequent request to fetch the next
    /// page of
    /// Amazon Web Services account preferences if the response payload was
    /// paginated.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const DescribeAccountPreferencesOutput = struct {
    /// Present if there are more records than returned in the response.
    /// You can use the `NextToken` in the subsequent request to fetch the
    /// additional descriptions.
    next_token: ?[]const u8 = null,

    /// Describes the resource ID preference setting for the Amazon Web Services
    /// account associated with the user making the request, in the current Amazon
    /// Web Services Region.
    resource_id_preference: ?ResourceIdPreference = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .resource_id_preference = "ResourceIdPreference",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeAccountPreferencesInput, options: CallOptions) !DescribeAccountPreferencesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "elasticfilesystem", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeAccountPreferencesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticfilesystem", "EFS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2015-02-01/account-preferences";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MaxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"NextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeAccountPreferencesOutput {
    var result: DescribeAccountPreferencesOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeAccountPreferencesOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
