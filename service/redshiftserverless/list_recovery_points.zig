const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RecoveryPoint = @import("recovery_point.zig").RecoveryPoint;

pub const ListRecoveryPointsInput = struct {
    /// The time when creation of the recovery point finished.
    end_time: ?i64 = null,

    /// An optional parameter that specifies the maximum number of results to
    /// return. You can use `nextToken` to display the next page of results.
    max_results: ?i32 = null,

    /// The Amazon Resource Name (ARN) of the namespace from which to list recovery
    /// points.
    namespace_arn: ?[]const u8 = null,

    /// The name of the namespace to list recovery points for.
    namespace_name: ?[]const u8 = null,

    /// If your initial `ListRecoveryPoints` operation returns a `nextToken`, you
    /// can include the returned `nextToken` in following `ListRecoveryPoints`
    /// operations, which returns results in the next page.
    next_token: ?[]const u8 = null,

    /// The time when the recovery point's creation was initiated.
    start_time: ?i64 = null,

    pub const json_field_names = .{
        .end_time = "endTime",
        .max_results = "maxResults",
        .namespace_arn = "namespaceArn",
        .namespace_name = "namespaceName",
        .next_token = "nextToken",
        .start_time = "startTime",
    };
};

pub const ListRecoveryPointsOutput = struct {
    /// If `nextToken` is returned, there are more results available. The value of
    /// `nextToken` is a unique pagination token for each page. Make the call again
    /// using the returned token to retrieve the next page.
    next_token: ?[]const u8 = null,

    /// The returned recovery point objects.
    recovery_points: ?[]const RecoveryPoint = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .recovery_points = "recoveryPoints",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListRecoveryPointsInput, options: CallOptions) !ListRecoveryPointsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "redshift-serverless", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListRecoveryPointsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("redshift-serverless", "Redshift Serverless", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "RedshiftServerless.ListRecoveryPoints");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListRecoveryPointsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListRecoveryPointsOutput, body, allocator);
}
