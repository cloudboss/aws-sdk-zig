const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const OperationSummary = @import("operation_summary.zig").OperationSummary;

pub const ListOperationsInput = struct {
    /// The maximum number of results to include in each response (result page).
    /// It's used for a paginated request.
    ///
    /// If you don't specify `MaxResults`, the request retrieves all available
    /// results in a single response.
    max_results: ?i32 = null,

    /// A token from a previous result page. It's used for a paginated request. The
    /// request retrieves the next result page. All other parameter values must be
    /// identical to the ones specified in the initial request.
    ///
    /// If you don't specify `NextToken`, the request retrieves the first result
    /// page.
    next_token: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the App Runner service that you want a
    /// list of operations for.
    service_arn: []const u8,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .service_arn = "ServiceArn",
    };
};

pub const ListOperationsOutput = struct {
    /// The token that you can pass in a subsequent request to get the next result
    /// page. It's returned in a paginated request.
    next_token: ?[]const u8 = null,

    /// A list of operation summary information records. In a paginated request, the
    /// request returns up to `MaxResults` records for each
    /// call.
    operation_summary_list: ?[]const OperationSummary = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .operation_summary_list = "OperationSummaryList",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListOperationsInput, options: CallOptions) !ListOperationsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "apprunner", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListOperationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("apprunner", "AppRunner", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AppRunner.ListOperations");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListOperationsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListOperationsOutput, body, allocator);
}
