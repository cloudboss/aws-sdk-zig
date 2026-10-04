const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MultiRegionParameter = @import("multi_region_parameter.zig").MultiRegionParameter;

pub const DescribeMultiRegionParametersInput = struct {
    /// The maximum number of records to include in the response. If more records
    /// exist than the specified MaxResults value, a token is included in the
    /// response so that the remaining results can be retrieved.
    max_results: ?i32 = null,

    /// The name of the multi-region parameter group to return details for.
    multi_region_parameter_group_name: []const u8,

    /// An optional token returned from a prior request. Use this token for
    /// pagination of results from this action. If this parameter is specified, the
    /// response includes only results beyond the token, up to the value specified
    /// by MaxResults.
    next_token: ?[]const u8 = null,

    /// The parameter types to return. Valid values: user | system | engine-default
    source: ?[]const u8 = null,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .multi_region_parameter_group_name = "MultiRegionParameterGroupName",
        .next_token = "NextToken",
        .source = "Source",
    };
};

pub const DescribeMultiRegionParametersOutput = struct {
    /// A list of parameters specific to a particular multi-region parameter group.
    /// Each element in the list contains detailed information about one parameter.
    multi_region_parameters: ?[]const MultiRegionParameter = null,

    /// An optional token to include in the response. If this token is provided, the
    /// response includes only results beyond the token, up to the value specified
    /// by MaxResults.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .multi_region_parameters = "MultiRegionParameters",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeMultiRegionParametersInput, options: CallOptions) !DescribeMultiRegionParametersOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "memorydb", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeMultiRegionParametersInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("memory-db", "MemoryDB", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonMemoryDB.DescribeMultiRegionParameters");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeMultiRegionParametersOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeMultiRegionParametersOutput, body, allocator);
}
