const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConnectionSummary = @import("connection_summary.zig").ConnectionSummary;

pub const ListConnectionsInput = struct {
    /// The catalog identifier for the partner account.
    catalog: []const u8,

    /// Filter results by connection type (e.g., reseller, distributor, technology
    /// partner).
    connection_type: ?[]const u8 = null,

    /// The maximum number of connections to return in a single response.
    max_results: ?i32 = null,

    /// The token for retrieving the next page of results in paginated responses.
    next_token: ?[]const u8 = null,

    /// Filter results by specific participant identifiers.
    other_participant_identifiers: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .catalog = "Catalog",
        .connection_type = "ConnectionType",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .other_participant_identifiers = "OtherParticipantIdentifiers",
    };
};

pub const ListConnectionsOutput = struct {
    /// A list of connection summaries matching the specified criteria.
    connection_summaries: ?[]const ConnectionSummary = null,

    /// The token for retrieving the next page of results if more results are
    /// available.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .connection_summaries = "ConnectionSummaries",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListConnectionsInput, options: CallOptions) !ListConnectionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "partnercentral", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListConnectionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("partnercentral-account", "PartnerCentral Account", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "PartnerCentralAccount.ListConnections");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListConnectionsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListConnectionsOutput, body, allocator);
}
