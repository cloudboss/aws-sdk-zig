const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Parameter = @import("parameter.zig").Parameter;

pub const DescribeDefaultParametersInput = struct {
    /// The maximum number of results to include in the response. If more results
    /// exist
    /// than the specified `MaxResults` value, a token is included in the response
    /// so
    /// that the remaining results can be retrieved.
    ///
    /// The value for `MaxResults` must be between 20 and 100.
    max_results: ?i32 = null,

    /// An optional token returned from a prior request. Use this token for
    /// pagination of
    /// results from this action. If this parameter is specified, the response
    /// includes only
    /// results beyond the token, up to the value specified by
    /// `MaxResults`.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const DescribeDefaultParametersOutput = struct {
    /// Provides an identifier to allow retrieval of paginated results.
    next_token: ?[]const u8 = null,

    /// A list of parameters. Each element in the list represents one parameter.
    parameters: ?[]const Parameter = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .parameters = "Parameters",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeDefaultParametersInput, options: CallOptions) !DescribeDefaultParametersOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "dax", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeDefaultParametersInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("dax", "DAX", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonDAXV3.DescribeDefaultParameters");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeDefaultParametersOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeDefaultParametersOutput, body, allocator);
}
