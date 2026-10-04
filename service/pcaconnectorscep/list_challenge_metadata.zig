const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ChallengeMetadataSummary = @import("challenge_metadata_summary.zig").ChallengeMetadataSummary;

pub const ListChallengeMetadataInput = struct {
    /// The Amazon Resource Name (ARN) of the connector.
    connector_arn: []const u8,

    /// The maximum number of objects that you want Connector for SCEP to return for
    /// this request. If more objects are available, in the response, Connector for
    /// SCEP provides a `NextToken` value that you can use in a subsequent call to
    /// get the next batch of objects.
    max_results: ?i32 = null,

    /// When you request a list of objects with a `MaxResults` setting, if the
    /// number of objects that are still available for retrieval exceeds the maximum
    /// you requested, Connector for SCEP returns a `NextToken` value in the
    /// response. To retrieve the next batch of objects, use the token returned from
    /// the prior request in your next request.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .connector_arn = "ConnectorArn",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListChallengeMetadataOutput = struct {
    /// The challenge metadata for the challenges belonging to your Amazon Web
    /// Services account.
    challenges: ?[]const ChallengeMetadataSummary = null,

    /// When you request a list of objects with a `MaxResults` setting, if the
    /// number of objects that are still available for retrieval exceeds the maximum
    /// you requested, Connector for SCEP returns a `NextToken` value in the
    /// response. To retrieve the next batch of objects, use the token returned from
    /// the prior request in your next request.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .challenges = "Challenges",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListChallengeMetadataInput, options: CallOptions) !ListChallengeMetadataOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "pca-connector-scep", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListChallengeMetadataInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("pca-connector-scep", "Pca Connector Scep", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/challengeMetadata";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "ConnectorArn=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.connector_arn);
    query_has_prev = true;
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "MaxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "NextToken=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListChallengeMetadataOutput {
    var result: ListChallengeMetadataOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListChallengeMetadataOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
