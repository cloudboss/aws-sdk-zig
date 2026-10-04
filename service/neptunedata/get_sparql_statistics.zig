const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Statistics = @import("statistics.zig").Statistics;

pub const GetSparqlStatisticsInput = struct {};

pub const GetSparqlStatisticsOutput = struct {
    /// Statistics for RDF data.
    payload: ?Statistics = null,

    /// The HTTP return code of the request. If the request succeeded, the code is
    /// 200. See [Common error codes for DFE statistics
    /// request](https://docs.aws.amazon.com/neptune/latest/userguide/neptune-dfe-statistics.html#neptune-dfe-statistics-errors) for a list of common errors.
    ///
    /// When invoking this operation in a Neptune cluster that has IAM
    /// authentication enabled, the IAM user or role making the request must have a
    /// policy attached that allows the
    /// [neptune-db:GetStatisticsStatus](https://docs.aws.amazon.com/neptune/latest/userguide/iam-dp-actions.html#getstatisticsstatus) IAM action in that cluster.
    status: []const u8,

    pub const json_field_names = .{
        .payload = "payload",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetSparqlStatisticsInput, options: CallOptions) !GetSparqlStatisticsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "neptune-db", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetSparqlStatisticsInput, config: *aws.Config) !aws.http.Request {
    _ = input;
    const endpoint = try config.getEndpointForService("neptune-db", "neptunedata", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/sparql/statistics";

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetSparqlStatisticsOutput {
    var result: GetSparqlStatisticsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetSparqlStatisticsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
