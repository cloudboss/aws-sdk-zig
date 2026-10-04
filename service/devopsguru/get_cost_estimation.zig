const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ServiceResourceCost = @import("service_resource_cost.zig").ServiceResourceCost;
const CostEstimationResourceCollectionFilter = @import("cost_estimation_resource_collection_filter.zig").CostEstimationResourceCollectionFilter;
const CostEstimationStatus = @import("cost_estimation_status.zig").CostEstimationStatus;
const CostEstimationTimeRange = @import("cost_estimation_time_range.zig").CostEstimationTimeRange;

pub const GetCostEstimationInput = struct {
    /// The pagination token to use to retrieve
    /// the next page of results for this operation. If this value is null, it
    /// retrieves the first page.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
    };
};

pub const GetCostEstimationOutput = struct {
    /// An array of `ResourceCost` objects that each contains details about the
    /// monthly cost estimate to analyze one of your Amazon Web Services resources.
    costs: ?[]const ServiceResourceCost = null,

    /// The pagination token to use to retrieve
    /// the next page of results for this operation. If there are no more pages,
    /// this value is null.
    next_token: ?[]const u8 = null,

    /// The collection of the Amazon Web Services resources used to create your
    /// monthly DevOps Guru cost
    /// estimate.
    resource_collection: ?CostEstimationResourceCollectionFilter = null,

    /// The status of creating this cost estimate. If it's still in progress, the
    /// status
    /// `ONGOING` is returned. If it is finished, the status
    /// `COMPLETED` is returned.
    status: ?CostEstimationStatus = null,

    /// The start and end time of the cost estimation.
    time_range: ?CostEstimationTimeRange = null,

    /// The estimated monthly cost to analyze the Amazon Web Services resources.
    /// This value is the sum of
    /// the estimated costs to analyze each resource in the `Costs` object in this
    /// response.
    total_cost: ?f64 = null,

    pub const json_field_names = .{
        .costs = "Costs",
        .next_token = "NextToken",
        .resource_collection = "ResourceCollection",
        .status = "Status",
        .time_range = "TimeRange",
        .total_cost = "TotalCost",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetCostEstimationInput, options: CallOptions) !GetCostEstimationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "devops-guru", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetCostEstimationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("devops-guru", "DevOps Guru", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/cost-estimation";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "NextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetCostEstimationOutput {
    const result: GetCostEstimationOutput = try aws.json.parseJsonObject(
        GetCostEstimationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
