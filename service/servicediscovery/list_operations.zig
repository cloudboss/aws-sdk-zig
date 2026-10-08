const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const OperationFilter = @import("operation_filter.zig").OperationFilter;
const OperationSummary = @import("operation_summary.zig").OperationSummary;

pub const ListOperationsInput = struct {
    /// A complex type that contains specifications for the operations that you want
    /// to list, for
    /// example, operations that you started between a specified start date and end
    /// date.
    ///
    /// If you specify more than one filter, an operation must match all filters to
    /// be returned by
    /// `ListOperations`.
    filters: ?[]const OperationFilter = null,

    /// The maximum number of items that you want Cloud Map to return in the
    /// response to a
    /// `ListOperations` request. If you don't specify a value for `MaxResults`,
    /// Cloud Map returns up to 100 operations.
    max_results: ?i32 = null,

    /// For the first `ListOperations` request, omit this value.
    ///
    /// If the response contains `NextToken`, submit another `ListOperations`
    /// request to get the next group of results. Specify the value of `NextToken`
    /// from the
    /// previous response in the next request.
    ///
    /// Cloud Map gets `MaxResults` operations and then filters them based on the
    /// specified criteria. It's possible that no operations in the first
    /// `MaxResults`
    /// operations matched the specified criteria but that subsequent groups of
    /// `MaxResults`
    /// operations do contain operations that match the criteria.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .filters = "Filters",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListOperationsOutput = struct {
    /// If the response contains `NextToken`, submit another `ListOperations`
    /// request to get the next group of results. Specify the value of `NextToken`
    /// from the
    /// previous response in the next request.
    ///
    /// Cloud Map gets `MaxResults` operations and then filters them based on the
    /// specified criteria. It's possible that no operations in the first
    /// `MaxResults`
    /// operations matched the specified criteria but that subsequent groups of
    /// `MaxResults`
    /// operations do contain operations that match the criteria.
    next_token: ?[]const u8 = null,

    /// Summary information about the operations that match the specified criteria.
    operations: ?[]const OperationSummary = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .operations = "Operations",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListOperationsInput, options: CallOptions) !ListOperationsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "servicediscovery", client.config.http_client.clock_skew_offset);

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
    const endpoint = try config.getEndpointForService("servicediscovery", "ServiceDiscovery", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Route53AutoNaming_v20170314.ListOperations");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListOperationsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListOperationsOutput, body, allocator);
}
