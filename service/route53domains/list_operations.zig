const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ListOperationsSortAttributeName = @import("list_operations_sort_attribute_name.zig").ListOperationsSortAttributeName;
const SortOrder = @import("sort_order.zig").SortOrder;
const OperationStatus = @import("operation_status.zig").OperationStatus;
const OperationType = @import("operation_type.zig").OperationType;
const OperationSummary = @import("operation_summary.zig").OperationSummary;

pub const ListOperationsInput = struct {
    /// For an initial request for a list of operations, omit this element. If the
    /// number of
    /// operations that are not yet complete is greater than the value that you
    /// specified for
    /// `MaxItems`, you can use `Marker` to return additional
    /// operations. Get the value of `NextPageMarker` from the previous response,
    /// and
    /// submit another request that includes the value of `NextPageMarker` in the
    /// `Marker` element.
    marker: ?[]const u8 = null,

    /// Number of domains to be returned.
    ///
    /// Default: 20
    max_items: ?i32 = null,

    /// The sort type for returned values.
    sort_by: ?ListOperationsSortAttributeName = null,

    /// The sort order for returned values, either ascending or descending.
    sort_order: ?SortOrder = null,

    /// The status of the operations.
    status: ?[]const OperationStatus = null,

    /// An optional parameter that lets you get information about all the operations
    /// that you
    /// submitted after a specified date and time. Specify the date and time in Unix
    /// time format
    /// and Coordinated Universal time (UTC).
    submitted_since: ?i64 = null,

    /// An arrays of the domains operation types.
    type: ?[]const OperationType = null,

    pub const json_field_names = .{
        .marker = "Marker",
        .max_items = "MaxItems",
        .sort_by = "SortBy",
        .sort_order = "SortOrder",
        .status = "Status",
        .submitted_since = "SubmittedSince",
        .type = "Type",
    };
};

pub const ListOperationsOutput = struct {
    /// If there are more operations than you specified for `MaxItems` in the
    /// request, submit another request and include the value of `NextPageMarker` in
    /// the value of `Marker`.
    next_page_marker: ?[]const u8 = null,

    /// Lists summaries of the operations.
    operations: ?[]const OperationSummary = null,

    pub const json_field_names = .{
        .next_page_marker = "NextPageMarker",
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
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "route53domains", client.config.http_client.clock_skew_offset);

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
    const endpoint = try config.getEndpointForService("route53domains", "Route 53 Domains", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Route53Domains_v20140515.ListOperations");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListOperationsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListOperationsOutput, body, allocator);
}
