const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DataLakeSource = @import("data_lake_source.zig").DataLakeSource;

pub const GetDataLakeSourcesInput = struct {
    /// The Amazon Web Services account ID for which a static snapshot of the
    /// current Amazon Web Services Region, including enabled accounts and log
    /// sources, is retrieved.
    accounts: ?[]const []const u8 = null,

    /// The maximum limit of accounts for which the static snapshot of the current
    /// Region,
    /// including enabled accounts and log sources, is retrieved.
    max_results: ?i32 = null,

    /// Lists if there are more results available. The value of nextToken is a
    /// unique pagination
    /// token for each page. Repeat the call using the returned token to retrieve
    /// the next page.
    /// Keep all other arguments unchanged.
    ///
    /// Each pagination token expires after 24 hours. Using an expired pagination
    /// token will
    /// return an HTTP 400 InvalidToken error.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .accounts = "accounts",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const GetDataLakeSourcesOutput = struct {
    /// The Amazon Resource Name (ARN) created by you to provide to the subscriber.
    /// For more information about ARNs and how to use them in policies, see the
    /// [Amazon Security Lake User
    /// Guide](https://docs.aws.amazon.com/security-lake/latest/userguide/subscriber-management.html).
    data_lake_arn: ?[]const u8 = null,

    /// The list of enabled accounts and enabled sources.
    data_lake_sources: ?[]const DataLakeSource = null,

    /// Lists if there are more results available. The value of nextToken is a
    /// unique pagination
    /// token for each page. Repeat the call using the returned token to retrieve
    /// the next page.
    /// Keep all other arguments unchanged.
    ///
    /// Each pagination token expires after 24 hours. Using an expired pagination
    /// token will
    /// return an HTTP 400 InvalidToken error.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .data_lake_arn = "dataLakeArn",
        .data_lake_sources = "dataLakeSources",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDataLakeSourcesInput, options: CallOptions) !GetDataLakeSourcesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "securitylake", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetDataLakeSourcesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("securitylake", "SecurityLake", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/datalake/sources";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.accounts) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"accounts\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"maxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"nextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDataLakeSourcesOutput {
    var result: GetDataLakeSourcesOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetDataLakeSourcesOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
