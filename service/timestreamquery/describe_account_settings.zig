const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const QueryComputeResponse = @import("query_compute_response.zig").QueryComputeResponse;
const QueryPricingModel = @import("query_pricing_model.zig").QueryPricingModel;

pub const DescribeAccountSettingsInput = struct {
};

pub const DescribeAccountSettingsOutput = struct {
    /// The maximum number of [Timestream compute
    /// units](https://docs.aws.amazon.com/timestream/latest/developerguide/tcu.html) (TCUs) the service will use at any point in time to serve your queries. To run queries, you must set a minimum capacity of 4 TCU. You can set the maximum number of TCU in multiples of 4, for example, 4, 8, 16, 32, and so on. This configuration is applicable only for on-demand usage of (TCUs).
    max_query_tcu: ?i32 = null,

    /// An object that contains the usage settings for Timestream Compute Units
    /// (TCUs) in your account for the query workload.
    query_compute: ?QueryComputeResponse = null,

    /// The pricing model for queries in your account.
    ///
    /// The `QueryPricingModel` parameter is used by several Timestream operations;
    /// however, the `UpdateAccountSettings` API operation doesn't recognize any
    /// values other than `COMPUTE_UNITS`.
    query_pricing_model: ?QueryPricingModel = null,

    pub const json_field_names = .{
        .max_query_tcu = "MaxQueryTCU",
        .query_compute = "QueryCompute",
        .query_pricing_model = "QueryPricingModel",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeAccountSettingsInput, options: CallOptions) !DescribeAccountSettingsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "timestream", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeAccountSettingsInput, config: *aws.Config) !aws.http.Request {
    _ = input;
    const endpoint = try config.getEndpointForService("query.timestream", "Timestream Query", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = "{}";

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "Timestream_20181101.DescribeAccountSettings");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeAccountSettingsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeAccountSettingsOutput, body, allocator);
}
