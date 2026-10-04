const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConfigurationRevision = @import("configuration_revision.zig").ConfigurationRevision;

pub const ListConfigurationRevisionsInput = struct {
    /// The unique ID that Amazon MQ generates for the configuration.
    configuration_id: []const u8,

    /// The maximum number of brokers that Amazon MQ can return per page (20 by
    /// default). This value must be an integer from 5 to 100.
    max_results: ?i32 = null,

    /// The token that specifies the next page of results Amazon MQ should return.
    /// To request the first page, leave nextToken empty.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .configuration_id = "ConfigurationId",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListConfigurationRevisionsOutput = struct {
    /// The unique ID that Amazon MQ generates for the configuration.
    configuration_id: ?[]const u8 = null,

    /// The maximum number of configuration revisions that can be returned per page
    /// (20 by default). This value must be an integer from 5 to 100.
    max_results: ?i32 = null,

    /// The token that specifies the next page of results Amazon MQ should return.
    /// To request the first page, leave nextToken empty.
    next_token: ?[]const u8 = null,

    /// The list of all revisions for the specified configuration.
    revisions: ?[]const ConfigurationRevision = null,

    pub const json_field_names = .{
        .configuration_id = "ConfigurationId",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .revisions = "Revisions",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListConfigurationRevisionsInput, options: CallOptions) !ListConfigurationRevisionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "mq", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListConfigurationRevisionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mq", "mq", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/configurations/");
    try path_buf.appendSlice(allocator, input.configuration_id);
    try path_buf.appendSlice(allocator, "/revisions");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListConfigurationRevisionsOutput {
    const result: ListConfigurationRevisionsOutput = try aws.json.parseJsonObject(
        ListConfigurationRevisionsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
