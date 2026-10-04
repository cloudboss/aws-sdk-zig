const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UltraServer = @import("ultra_server.zig").UltraServer;

pub const ListUltraServersByReservedCapacityInput = struct {
    /// The maximum number of UltraServers to return in the response. The default
    /// value is 10.
    max_results: ?i32 = null,

    /// If the previous response was truncated, you receive this token. Use it in
    /// your next request to receive the next set of results.
    next_token: ?[]const u8 = null,

    /// The ARN of the reserved capacity to list UltraServers for.
    reserved_capacity_arn: []const u8,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .reserved_capacity_arn = "ReservedCapacityArn",
    };
};

pub const ListUltraServersByReservedCapacityOutput = struct {
    /// If the response is truncated, SageMaker returns this token. Use it in the
    /// next request to retrieve the next set of UltraServers.
    next_token: ?[]const u8 = null,

    /// A list of UltraServers that are part of the specified reserved capacity.
    ultra_servers: ?[]const UltraServer = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .ultra_servers = "UltraServers",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListUltraServersByReservedCapacityInput, options: CallOptions) !ListUltraServersByReservedCapacityOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sagemaker", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListUltraServersByReservedCapacityInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.sagemaker", "SageMaker", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.ListUltraServersByReservedCapacity");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListUltraServersByReservedCapacityOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListUltraServersByReservedCapacityOutput, body, allocator);
}
