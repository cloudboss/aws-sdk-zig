const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DeleteStatisticsValueMap = @import("delete_statistics_value_map.zig").DeleteStatisticsValueMap;

pub const DeletePropertygraphStatisticsInput = struct {};

pub const DeletePropertygraphStatisticsOutput = struct {
    /// The deletion payload.
    payload: ?DeleteStatisticsValueMap = null,

    /// The cancel status.
    status: ?[]const u8 = null,

    /// The HTTP response code: 200 if the delete was successful, or 204 if there
    /// were no statistics to delete.
    status_code: ?i32 = null,

    pub const json_field_names = .{
        .payload = "payload",
        .status = "status",
        .status_code = "statusCode",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeletePropertygraphStatisticsInput, options: CallOptions) !DeletePropertygraphStatisticsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeletePropertygraphStatisticsInput, config: *aws.Config) !aws.http.Request {
    _ = input;
    const endpoint = try config.getEndpointForService("neptune-db", "neptunedata", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/propertygraph/statistics";

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .DELETE;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeletePropertygraphStatisticsOutput {
    var result: DeletePropertygraphStatisticsOutput = try aws.json.parseJsonObject(
        DeletePropertygraphStatisticsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    result.status_code = @intCast(status);
    _ = headers;

    return result;
}
