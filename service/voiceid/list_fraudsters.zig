const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FraudsterSummary = @import("fraudster_summary.zig").FraudsterSummary;

pub const ListFraudstersInput = struct {
    /// The identifier of the domain.
    domain_id: []const u8,

    /// The maximum number of results that are returned per call. You can use
    /// `NextToken` to obtain more pages of results. The default is 100; the maximum
    /// allowed page size is also 100.
    max_results: ?i32 = null,

    /// If `NextToken` is returned, there are more results available. The value of
    /// `NextToken` is a unique pagination token for each page. Make the call
    /// again using the returned token to retrieve the next page. Keep all other
    /// arguments
    /// unchanged. Each pagination token expires after 24 hours.
    next_token: ?[]const u8 = null,

    /// The identifier of the watchlist. If provided, all fraudsters in the
    /// watchlist are listed. If not provided, all fraudsters in the domain are
    /// listed.
    watchlist_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .domain_id = "DomainId",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .watchlist_id = "WatchlistId",
    };
};

pub const ListFraudstersOutput = struct {
    /// A list that contains details about each fraudster in the Amazon Web Services
    /// account.
    fraudster_summaries: ?[]const FraudsterSummary = null,

    /// If `NextToken` is returned, there are more results available. The value of
    /// `NextToken` is a unique pagination token for each page. Make the call
    /// again using the returned token to retrieve the next page. Keep all other
    /// arguments
    /// unchanged. Each pagination token expires after 24 hours.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .fraudster_summaries = "FraudsterSummaries",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListFraudstersInput, options: CallOptions) !ListFraudstersOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "voiceid", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListFraudstersInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("voiceid", "Voice ID", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "VoiceID.ListFraudsters");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListFraudstersOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListFraudstersOutput, body, allocator);
}
