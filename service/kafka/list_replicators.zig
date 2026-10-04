const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ReplicatorSummary = @import("replicator_summary.zig").ReplicatorSummary;

pub const ListReplicatorsInput = struct {
    /// The maximum number of results to return in the response. If there are more
    /// results, the response includes a NextToken parameter.
    max_results: ?i32 = null,

    /// If the response of ListReplicators is truncated, it returns a NextToken in
    /// the response. This NextToken should be sent in the subsequent request to
    /// ListReplicators.
    next_token: ?[]const u8 = null,

    /// Returns replicators starting with given name.
    replicator_name_filter: ?[]const u8 = null,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .replicator_name_filter = "ReplicatorNameFilter",
    };
};

pub const ListReplicatorsOutput = struct {
    /// If the response of ListReplicators is truncated, it returns a NextToken in
    /// the response. This NextToken should be sent in the subsequent request to
    /// ListReplicators.
    next_token: ?[]const u8 = null,

    /// List containing information of each of the replicators in the account.
    replicators: ?[]const ReplicatorSummary = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .replicators = "Replicators",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListReplicatorsInput, options: CallOptions) !ListReplicatorsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "kafka", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListReplicatorsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kafka", "Kafka", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/replication/v1/replicators";

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
    if (input.replicator_name_filter) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "replicatorNameFilter=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListReplicatorsOutput {
    var result: ListReplicatorsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListReplicatorsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
