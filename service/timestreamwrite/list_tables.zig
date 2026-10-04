const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Table = @import("table.zig").Table;

pub const ListTablesInput = struct {
    /// The name of the Timestream database.
    database_name: ?[]const u8 = null,

    /// The total number of items to return in the output. If the total number of
    /// items
    /// available is more than the value specified, a NextToken is provided in the
    /// output. To
    /// resume pagination, provide the NextToken value as argument of a subsequent
    /// API
    /// invocation.
    max_results: ?i32 = null,

    /// The pagination token. To resume pagination, provide the NextToken value as
    /// argument of a
    /// subsequent API invocation.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .database_name = "DatabaseName",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListTablesOutput = struct {
    /// A token to specify where to start paginating. This is the NextToken from a
    /// previously
    /// truncated response.
    next_token: ?[]const u8 = null,

    /// A list of tables.
    tables: ?[]const Table = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .tables = "Tables",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListTablesInput, options: CallOptions) !ListTablesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "timestream", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListTablesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ingest.timestream", "Timestream Write", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "Timestream_20181101.ListTables");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListTablesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListTablesOutput, body, allocator);
}
